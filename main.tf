locals {
  tags = [
    "ruby",
    "rails",
    "plant-coach",
    "dev",
    "terraform",
    "terraform-cloud"
  ]
  k8s_version        = "1.32"
  postgresql_version = "17"
}

module "cluster" {
  source = "./modules/cluster"

  app_name            = var.app_name
  digitalocean_region = var.digitalocean_region
  k8s_version         = local.k8s_version
  node_pool_size      = var.node_pool_size
  node_count          = var.node_count
  tags                = local.tags
}

module "database" {
  source = "./modules/database"

  database_cluster_name        = var.database_cluster_name
  postgresql_version           = local.postgresql_version
  db_cluster_size              = var.db_cluster_size
  digitalocean_database_region = var.digitalocean_database_region
  db_cluster_node_count        = var.db_cluster_node_count
  tags                         = local.tags
  database_name                = var.database_name
  backend_database_user_name   = var.backend_database_user_name
  kubernetes_cluster_id        = module.cluster.cluster_id
  allowed_ip_addresses         = compact([var.ip_address_1, var.ip_address_2])
  connection_pool_size         = 5
}

module "projects" {
  source = "./modules/projects"

  project_name         = var.project_name
  project_description  = var.project_description
  environment          = var.environment
  cluster_urn          = module.cluster.cluster_id
  database_cluster_urn = module.database.cluster_id
}