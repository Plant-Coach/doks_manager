# Example Usage

This directory contains example configurations showing how to use the DOKS Manager modules.

## Basic Example

```hcl
# examples/basic/main.tf

terraform {
  required_version = ">= 1.0"
  
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.51.0"
    }
  }
}

provider "digitalocean" {
  # Configure your DigitalOcean token via environment variable:
  # export DIGITALOCEAN_TOKEN="your_token_here"
}

locals {
  tags = ["terraform", "example", "basic"]
}

module "cluster" {
  source = "../../modules/cluster"

  app_name             = "example-app"
  digitalocean_region  = "nyc1"
  k8s_version         = "1.32"
  node_pool_size      = "s-2vcpu-2gb"
  node_count          = "2"
  tags                = local.tags
}

module "database" {
  source = "../../modules/database"

  database_cluster_name        = "example-db-cluster"
  postgresql_version          = "17"
  db_cluster_size            = "db-s-1vcpu-1gb"
  digitalocean_database_region = "nyc2"
  db_cluster_node_count      = 1
  database_name              = "exampleapp"
  backend_database_user_name = "app_user"
  kubernetes_cluster_id      = module.cluster.cluster_id
  allowed_ip_addresses       = ["203.0.113.1"] # Replace with your IP
  tags                       = local.tags
}

module "projects" {
  source = "../../modules/projects"

  project_name        = "example-project"
  project_description = "Example web application"
  environment         = "development"
  cluster_urn         = module.cluster.cluster_id
  database_cluster_urn = module.database.cluster_id
}

# Outputs
output "cluster_endpoint" {
  description = "Kubernetes cluster endpoint"
  value       = module.cluster.cluster_endpoint
}

output "database_host" {
  description = "Database host"
  value       = module.database.cluster_host
}

output "project_id" {
  description = "DigitalOcean project ID"
  value       = module.projects.project_id
}
```

## Multi-Environment Example

```hcl
# examples/multi-env/main.tf

# Staging Environment
module "staging_cluster" {
  source = "../../modules/cluster"

  app_name             = "myapp-staging"
  digitalocean_region  = "nyc1"
  node_pool_size      = "s-1vcpu-2gb"
  node_count          = "1"
  tags                = ["staging", "terraform"]
}

module "staging_database" {
  source = "../../modules/database"

  database_cluster_name        = "myapp-staging-db"
  db_cluster_size            = "db-s-1vcpu-1gb"
  digitalocean_database_region = "nyc1"
  db_cluster_node_count      = 1
  database_name              = "myapp_staging"
  backend_database_user_name = "staging_user"
  kubernetes_cluster_id      = module.staging_cluster.cluster_id
  tags                       = ["staging", "terraform"]
}

# Production Environment  
module "production_cluster" {
  source = "../../modules/cluster"

  app_name             = "myapp-production"
  digitalocean_region  = "nyc1"
  node_pool_size      = "s-2vcpu-4gb"
  node_count          = "3"
  tags                = ["production", "terraform"]
}

module "production_database" {
  source = "../../modules/database"

  database_cluster_name        = "myapp-production-db"
  db_cluster_size            = "db-s-2vcpu-4gb"
  digitalocean_database_region = "nyc1"
  db_cluster_node_count      = 3
  database_name              = "myapp_production"
  backend_database_user_name = "prod_user"
  kubernetes_cluster_id      = module.production_cluster.cluster_id
  tags                       = ["production", "terraform"]
}
```

## Usage Instructions

1. Copy one of the example configurations
2. Modify the variables to match your requirements
3. Set your DigitalOcean token: `export DIGITALOCEAN_TOKEN="your_token"`
4. Initialize Terraform: `terraform init`
5. Plan the deployment: `terraform plan`
6. Apply the configuration: `terraform apply`
