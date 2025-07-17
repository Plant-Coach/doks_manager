# DOKS MANAGER 
*(aka, "DigitalOcean Kubernetes Manager")*

## Project Description
This (demo) Terraform repo deploys and maintains Kubernetes clusters for running an application and a Postgresql database on the cloud hosting platform DigitalOcean.  

# DigitalOcean Kubernetes Manager (DOKS Manager)

A modular Terraform configuration for creating and managing DigitalOcean Kubernetes clusters, PostgreSQL databases, and project organization.

## Overview

This originally was my IaaC solution for one of my Rails projects, but reusability came to mind so I have continue to migrate it towards a reusable, user-friendly (and well-documented) Terraform Module with which anyone can instantly create their own ready-to-go Kubernetes clusters and databases with minimal effort.

The configuration is now modularized into three main components:

- **Cluster Module** (`modules/cluster/`) - Manages DigitalOcean Kubernetes clusters
- **Database Module** (`modules/database/`) - Manages PostgreSQL database clusters with connection pools and firewall rules
- **Projects Module** (`modules/projects/`) - Organizes resources within DigitalOcean projects

## Architecture

```
Root Module
├── modules/
│   ├── cluster/          # Kubernetes cluster resources
│   ├── database/         # PostgreSQL database resources
│   └── projects/         # DigitalOcean project organization
├── main.tf              # Module instantiations
├── outputs.tf           # Module outputs
├── variables.tf         # Input variables
├── provider.tf          # Provider configuration
└── backend.tf           # Terraform backend configuration
```

## Usage

1. **Clone the repository**
2. **Configure variables** - Update `vars.tf` or use Terraform Cloud workspace variables
3. **Initialize Terraform**
   ```bash
   terraform init
   ```
4. **Plan the deployment**
   ```bash
   terraform plan
   ```
5. **Apply the configuration**
   ```bash
   terraform apply
   ```

## Modules

### Cluster Module
Creates a DigitalOcean Kubernetes cluster with configurable node pools.

### Database Module  
Creates a PostgreSQL database cluster with:
- Database and user creation
- Connection pooling
- Firewall rules (Kubernetes cluster access + optional IP allowlist)

### Projects Module
Organizes all resources within a DigitalOcean project for better management.

## Variables

Key variables that need to be configured:

| Variable | Description | Default |
|----------|-------------|---------|
| `app_name` | Application name | `"app_name"` |
| `project_name` | DigitalOcean project name | `"project_name"` |
| `database_cluster_name` | Database cluster name | `"database_cluster_name"` |
| `database_name` | Database name | `"database_name"` |
| `backend_database_user_name` | Database user name | `"backend_database_user_name"` |
| `digitalocean_region` | Kubernetes cluster region | `"nyc1"` |
| `digitalocean_database_region` | Database region | `"nyc2"` |
| `node_pool_size` | Node size | `"s-2vcpu-2gb"` |
| `db_cluster_size` | Database cluster size | `"db-s-1vcpu-1gb"` |
| `ip_address_1` | Allowed IP for database access | (sensitive) |

## Outputs

The configuration provides outputs for:
- Database connection details
- Kubernetes cluster information  
- Project organization details

## Requirements

- Terraform >= 1.0
- DigitalOcean provider ~> 2.51.0
- DigitalOcean API token configured

## Security Notes

- Database URIs are marked as sensitive outputs
- IP address variables are marked as sensitive
- Firewall rules restrict database access to the Kubernetes cluster and specified IPs

## Development

To extend this configuration:

1. **Add new modules** in the `modules/` directory
2. **Update the root module** to use new modules in `main.tf`
3. **Add appropriate outputs** in `outputs.tf`
4. **Document changes** in module README files

## Requirements
- Terraform Cloud
- Digital Ocean Account

## Current Features
- Creates Kubernetes cluster.
- Creates Kubernetes Postgresql cluster.
- Creates firewall permissions.
- Creates basic database defaults.
- Completely customizable through variables inherited through the user's own Terraform Cloud workspace variables.

## Future Features
- [ ] Customized GitHub actions with plan/apply/validation jobs.
- [ ] More dynamic to allow for limitless whitelisting.
- [ ] Scaling options
- [ ] Instructions for future users :)


DOCTL Setup
[Digital Ocean DOCTL docs](https://docs.digitalocean.com/reference/doctl/how-to/install/)
`brew install doctl`
