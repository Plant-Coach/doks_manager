# Database Module

This module creates a DigitalOcean PostgreSQL database cluster with associated resources including a database, user, connection pool, and firewall rules.

## Usage

```hcl
module "database" {
  source = "./modules/database"

  database_cluster_name        = "my-db-cluster"
  postgresql_version          = "17"
  db_cluster_size            = "db-s-1vcpu-1gb"
  digitalocean_database_region = "nyc2"
  db_cluster_node_count      = 1
  database_name              = "myapp"
  backend_database_user_name = "myapp_user"
  kubernetes_cluster_id      = module.cluster.cluster_id
  allowed_ip_addresses       = ["192.168.1.100"]
  tags                       = ["terraform", "database"]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| database_cluster_name | The name of the database cluster | `string` | n/a | yes |
| postgresql_version | The PostgreSQL version | `string` | `"17"` | no |
| db_cluster_size | The size of the database cluster | `string` | n/a | yes |
| digitalocean_database_region | The DigitalOcean region where the database will be created | `string` | n/a | yes |
| db_cluster_node_count | The number of database nodes | `number` | n/a | yes |
| tags | Tags to apply to resources | `list(string)` | `[]` | no |
| database_name | The name of the database | `string` | n/a | yes |
| backend_database_user_name | The name of the database user | `string` | n/a | yes |
| kubernetes_cluster_id | The ID of the Kubernetes cluster for firewall rules | `string` | n/a | yes |
| allowed_ip_addresses | List of IP addresses allowed to access the database | `list(string)` | `[]` | no |
| connection_pool_size | Size of the database connection pool | `number` | `5` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster_id | The ID of the database cluster |
| cluster_name | The name of the database cluster |
| cluster_host | The host of the database cluster |
| cluster_port | The port of the database cluster |
| cluster_private_host | The private host of the database cluster |
| cluster_uri | The URI of the database cluster (sensitive) |
| cluster_private_uri | The private URI of the database cluster (sensitive) |
| database_name | The name of the database |
| user_name | The name of the database user |
| connection_pool_name | The name of the connection pool |
