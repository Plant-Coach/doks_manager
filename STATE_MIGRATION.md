# State Migration Guide for DOKS Manager Modules

This guide shows how to migrate existing Terraform state when moving from a monolithic configuration to modules.

## Prerequisites

1. **Check Terraform version compatibility:**
   ```bash
   terraform version
   ```
   Ensure your local Terraform version meets the workspace requirements (~> 1.12.0). If you get version errors:
   - Upgrade Terraform: `brew upgrade terraform` (macOS) or download from https://www.terraform.io/downloads.html
   - Or update workspace settings in Terraform Cloud to match your local version

2. **Backup your state file:**
   ```bash
   cp terraform.tfstate terraform.tfstate.backup
   ```

3. **Get resource IDs from current state:**
   ```bash
   terraform show
   # or
   terraform state list
   ```

## Resource Mapping and Import Commands

### Database Resources

#### 1. Database Cluster
```bash
# Old resource: digitalocean_database_cluster.plant_coach_be_cluster
# New location: module.database.digitalocean_database_cluster.cluster

# Get the cluster ID first
terraform state show digitalocean_database_cluster.plant_coach_be_cluster

# Import to module
terraform import module.database.digitalocean_database_cluster.cluster CLUSTER_ID
```

#### 2. Database
```bash
# Old: digitalocean_database_db.plant-coach-database
# New: module.database.digitalocean_database_db.database

terraform import module.database.digitalocean_database_db.database CLUSTER_ID/DATABASE_NAME
```

#### 3. Database User
```bash
# Old: digitalocean_database_user.plant-coach-db-user
# New: module.database.digitalocean_database_user.user

terraform import module.database.digitalocean_database_user.user CLUSTER_ID/USERNAME
```

#### 4. Connection Pool
```bash
# Old: digitalocean_database_connection_pool.pool-01
# New: module.database.digitalocean_database_connection_pool.pool

terraform import module.database.digitalocean_database_connection_pool.pool CLUSTER_ID/POOL_NAME
```

#### 5. Database Firewall
```bash
# Old: digitalocean_database_firewall.plant_coach_db_firewall
# New: module.database.digitalocean_database_firewall.firewall

terraform import module.database.digitalocean_database_firewall.firewall CLUSTER_ID
```

### Kubernetes Cluster Resources

#### 1. Kubernetes Cluster
```bash
# Old: digitalocean_kubernetes_cluster.plant_coach_cluster
# New: module.cluster.digitalocean_kubernetes_cluster.cluster

terraform import module.cluster.digitalocean_kubernetes_cluster.cluster CLUSTER_ID
```

## Alternative Approach: State Move Commands

Instead of importing, you can move existing state entries to the new module locations:

### Move Database Resources
```bash
terraform state mv digitalocean_database_cluster.plant_coach_be_cluster module.database.digitalocean_database_cluster.cluster
terraform state mv digitalocean_database_db.plant-coach-database module.database.digitalocean_database_db.database
terraform state mv digitalocean_database_user.plant-coach-db-user module.database.digitalocean_database_user.user
terraform state mv digitalocean_database_connection_pool.pool-01 module.database.digitalocean_database_connection_pool.pool
terraform state mv digitalocean_database_firewall.plant_coach_db_firewall module.database.digitalocean_database_firewall.firewall
```

### Move Cluster Resources
```bash
terraform state mv digitalocean_kubernetes_cluster.plant_coach_cluster module.cluster.digitalocean_kubernetes_cluster.cluster
```

## Step-by-Step Migration Process

### Method 1: Using terraform state mv (Recommended)

1. **Initialize the new modular configuration:**
   ```bash
   terraform init
   ```

2. **Move existing resources to modules:**
   ```bash
   # Database resources
   terraform state mv digitalocean_database_cluster.plant_coach_be_cluster module.database.digitalocean_database_cluster.cluster
   terraform state mv digitalocean_database_db.plant-coach-database module.database.digitalocean_database_db.database
   terraform state mv digitalocean_database_user.plant-coach-db-user module.database.digitalocean_database_user.user
   terraform state mv digitalocean_database_connection_pool.pool-01 module.database.digitalocean_database_connection_pool.pool
   terraform state mv digitalocean_database_firewall.plant_coach_db_firewall module.database.digitalocean_database_firewall.firewall
   
   # Cluster resources
   terraform state mv digitalocean_kubernetes_cluster.plant_coach_cluster module.cluster.digitalocean_kubernetes_cluster.cluster
   ```

3. **Verify the migration:**
   ```bash
   terraform plan
   ```
   This should show no changes if the migration was successful.

### Method 2: Using terraform import

1. **Remove old resources from state:**
   ```bash
   terraform state rm digitalocean_database_cluster.plant_coach_be_cluster
   terraform state rm digitalocean_database_db.plant-coach-database
   terraform state rm digitalocean_database_user.plant-coach-db-user
   terraform state rm digitalocean_database_connection_pool.pool-01
   terraform state rm digitalocean_database_firewall.plant_coach_db_firewall
   terraform state rm digitalocean_kubernetes_cluster.plant_coach_cluster
   ```

2. **Import into modules:**
   ```bash
   # Get resource IDs from DigitalOcean dashboard or API
   # Then import each resource to its new module location
   terraform import module.database.digitalocean_database_cluster.cluster CLUSTER_ID
   terraform import module.database.digitalocean_database_db.database CLUSTER_ID/DATABASE_NAME
   # ... etc for other resources
   ```

## Verification Steps

1. **Check state after migration:**
   ```bash
   terraform state list
   ```
   You should see resources prefixed with `module.database.` and `module.cluster.`

2. **Run terraform plan:**
   ```bash
   terraform plan
   ```
   Should show no changes if migration was successful.

3. **If there are differences, check:**
   - Variable values match between old and new configurations
   - Resource attributes are correctly mapped
   - Dependencies are properly defined

## Troubleshooting

### Common Issues:

1. **Resource not found errors:**
   - Verify resource IDs are correct
   - Check that the resource exists in DigitalOcean

2. **Configuration differences:**
   - Compare old and new resource configurations
   - Ensure all attributes are mapped correctly

3. **Dependency issues:**
   - Verify module dependencies are correct
   - Check that inter-module references use outputs

### Getting Resource IDs:

```bash
# List all resources in current state
terraform state list

# Show details of a specific resource
terraform state show digitalocean_database_cluster.plant_coach_be_cluster

# Get resource ID from DigitalOcean CLI
doctl databases list
doctl kubernetes cluster list
```

## Notes

- Always backup your state file before making changes
- Test the migration in a non-production environment first
- The `terraform state mv` approach is generally safer than import/remove
- Verify that all module variables are properly configured before migration
