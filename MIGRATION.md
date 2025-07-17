# Migration Guide

This guide explains the modularization changes made to the DOKS Manager configuration.

## What Changed

### Before (Monolithic Configuration)
- All resources were defined directly in the root module
- `main.tf` contained the Kubernetes cluster resource
- `database-resources.tf` contained all database-related resources
- No project organization

### After (Modular Configuration)
- Resources are organized into three focused modules:
  - `modules/cluster/` - Kubernetes cluster management
  - `modules/database/` - Database cluster management  
  - `modules/projects/` - DigitalOcean project organization
- Root module orchestrates the modules
- Clear separation of concerns

## File Changes

| Original File | New Location/Purpose |
|---------------|----------------------|
| `main.tf` | Now contains module calls instead of direct resources |
| `database-resources.tf` | Renamed to `outputs.tf` - contains module outputs |
| N/A | `modules/cluster/` - New cluster module |
| N/A | `modules/database/` - New database module |
| N/A | `modules/projects/` - New projects module |

## Resource Mapping

### Kubernetes Cluster Resources
- **Before**: `digitalocean_kubernetes_cluster.plant_coach_cluster` in `main.tf`
- **After**: `digitalocean_kubernetes_cluster.cluster` in `modules/cluster/main.tf`

### Database Resources
- **Before**: `digitalocean_database_cluster.plant_coach_be_cluster` in `database-resources.tf`
- **After**: `digitalocean_database_cluster.cluster` in `modules/database/main.tf`

- **Before**: `digitalocean_database_db.plant-coach-database` in `database-resources.tf`  
- **After**: `digitalocean_database_db.database` in `modules/database/main.tf`

- **Before**: `digitalocean_database_user.plant-coach-db-user` in `database-resources.tf`
- **After**: `digitalocean_database_user.user` in `modules/database/main.tf`

- **Before**: `digitalocean_database_connection_pool.pool-01` in `database-resources.tf`
- **After**: `digitalocean_database_connection_pool.pool` in `modules/database/main.tf`

- **Before**: `digitalocean_database_firewall.plant_coach_db_firewall` in `database-resources.tf`
- **After**: `digitalocean_database_firewall.firewall` in `modules/database/main.tf`

### New Resources
- **Added**: `digitalocean_project.project` in `modules/projects/main.tf`

## Benefits

### Modularity
- Each module has a single responsibility
- Modules can be reused across different environments
- Easier to test individual components

### Maintainability  
- Clear separation of concerns
- Easier to understand and modify
- Better documentation per module

### Flexibility
- Can easily swap out individual modules
- Modules can be versioned independently
- Supports different configurations per environment

### Best Practices
- Follows Terraform module conventions
- Proper input validation and outputs
- Comprehensive documentation

## Migration Steps

If you have an existing Terraform state:

1. **Backup your state file**
2. **Plan the changes** with `terraform plan` to see the impact
3. **Use terraform state mv** commands to move resources to their new module locations
4. **Verify** with `terraform plan` that no resources will be recreated

Note: Since this is marked as "nothing should be applied", these are the files as they would exist for a new deployment.

## Usage Examples

### Basic Usage
```hcl
# Root module now simply calls child modules
module "cluster" {
  source = "./modules/cluster"
  # ... variables
}

module "database" {
  source = "./modules/database"
  # ... variables
}

module "projects" {
  source = "./modules/projects"
  # ... variables
}
```

### Advanced Usage
```hcl
# Multiple environments using the same modules
module "staging_cluster" {
  source = "./modules/cluster"
  app_name = "myapp-staging"
  # ... other variables
}

module "production_cluster" {
  source = "./modules/cluster"
  app_name = "myapp-production"
  # ... other variables
}
```
