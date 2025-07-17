#!/bin/bash

# State Migration Script for DOKS Manager Modules
# This script helps migrate existing Terraform state to the new modular structure

set -e

echo "🔄 DOKS Manager State Migration Script"
echo "======================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

# Check if terraform is installed
if ! command -v terraform &> /dev/null; then
    print_error "Terraform is not installed or not in PATH"
    exit 1
fi

# Backup current state
echo ""
print_warning "Creating backup of current state..."
if [ -f "terraform.tfstate" ]; then
    cp terraform.tfstate "terraform.tfstate.backup.$(date +%Y%m%d_%H%M%S)"
    print_status "State backup created"
else
    print_warning "No terraform.tfstate file found - this might be a remote state"
fi

# Initialize terraform to ensure modules are available
echo ""
print_warning "Initializing Terraform..."
terraform init
print_status "Terraform initialized"

# Check current state
echo ""
print_warning "Checking current state..."
if terraform state list | grep -q "digitalocean_"; then
    print_status "Found existing resources in state"
    echo ""
    echo "Current resources:"
    terraform state list | grep "digitalocean_"
else
    print_warning "No DigitalOcean resources found in current state"
    echo "This script is intended for migrating existing resources to modules."
    exit 0
fi

# Ask user to confirm migration
echo ""
read -p "Do you want to proceed with state migration? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Migration cancelled"
    exit 0
fi

echo ""
print_warning "Starting state migration..."

# Function to move state if resource exists
move_state_if_exists() {
    local old_resource=$1
    local new_resource=$2
    
    if terraform state list | grep -q "^${old_resource}$"; then
        echo "Moving: ${old_resource} -> ${new_resource}"
        terraform state mv "${old_resource}" "${new_resource}"
        print_status "Moved ${old_resource}"
    else
        print_warning "Resource ${old_resource} not found in state, skipping"
    fi
}

# Move cluster resources
echo ""
print_warning "Migrating cluster resources..."
move_state_if_exists "digitalocean_kubernetes_cluster.plant_coach_cluster" "module.cluster.digitalocean_kubernetes_cluster.cluster"

# Move database resources
echo ""
print_warning "Migrating database resources..."
move_state_if_exists "digitalocean_database_cluster.plant_coach_be_cluster" "module.database.digitalocean_database_cluster.cluster"
move_state_if_exists "digitalocean_database_db.plant-coach-database" "module.database.digitalocean_database_db.database"
move_state_if_exists "digitalocean_database_user.plant-coach-db-user" "module.database.digitalocean_database_user.user"
move_state_if_exists "digitalocean_database_connection_pool.pool-01" "module.database.digitalocean_database_connection_pool.pool"
move_state_if_exists "digitalocean_database_firewall.plant_coach_db_firewall" "module.database.digitalocean_database_firewall.firewall"

# Verify migration
echo ""
print_warning "Verifying migration..."
echo ""
echo "Resources after migration:"
terraform state list | sort

echo ""
print_warning "Running terraform plan to verify migration..."
if terraform plan -detailed-exitcode > /dev/null 2>&1; then
    print_status "Migration successful! No changes detected in plan."
else
    exit_code=$?
    if [ $exit_code -eq 2 ]; then
        print_warning "Plan shows changes. This might be expected if there are configuration differences."
        echo ""
        echo "Run 'terraform plan' to see the details."
        echo "Common reasons for changes:"
        echo "- Resource naming differences"
        echo "- New variables or default values"
        echo "- Additional resources (like projects module)"
    else
        print_error "Error running terraform plan. Check your configuration."
        exit $exit_code
    fi
fi

echo ""
print_status "State migration completed!"
echo ""
echo "Next steps:"
echo "1. Run 'terraform plan' to review any remaining changes"
echo "2. If you see expected changes (like new project resources), run 'terraform apply'"
echo "3. Test your infrastructure to ensure everything works correctly"
echo ""
echo "If something went wrong, you can restore from backup:"
echo "cp terraform.tfstate.backup.* terraform.tfstate"
