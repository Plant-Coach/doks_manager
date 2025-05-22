locals {
  tags = [
    "ruby",
    "rails",
    "plant-coach",
    "dev",
    "terraform",
    "terraform-cloud"
  ]
  k8s_version = "1.32"
  application_timezone = "EST"
  postgresql_version = "17"
}

resource "digitalocean_project" "plant_coach" {
  name        = var.project_name
  description = var.project_description
  purpose     = "Web Application"
  environment = var.environment
  resources = [
    digitalocean_kubernetes_cluster.plant_coach_cluster.urn,
    digitalocean_database_cluster.plant_coach_be_cluster.urn
  ]
}

resource "digitalocean_kubernetes_cluster" "plant_coach_cluster" {
  name   = var.app_name
  region = var.digitalocean_region
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = local.k8s_version

  tags = local.tags

  node_pool {
    name       = "${var.app_name}-worker-pool"
    size       = var.node_pool_size
    node_count = var.node_count
    tags = local.tags
  }
}

resource "digitalocean_database_postgresql_config" "plant_coach_be_cluster" {
  cluster_id = digitalocean_database_cluster.plant_coach_be_cluster.id
  timezone   = local.application_timezone
}

resource "digitalocean_database_db" "plant-coach-database" {
  cluster_id = digitalocean_database_cluster.plant_coach_be_cluster.id
  name       = var.database_name
}

resource "digitalocean_database_user" "plant-coach-db-user" {
  cluster_id = digitalocean_database_cluster.plant_coach_be_cluster.id
  name       = var.backend_database_user_name
}

resource "digitalocean_database_cluster" "plant_coach_be_cluster" {
  name       = var.database_cluster_name
  engine     = "pg"
  version    = local.postgresql_version
  size       = var.db_cluster_size
  region     = var.digitalocean_database_region
  node_count = var.db_cluster_node_count
  tags = local.tags
}

resource "digitalocean_database_connection_pool" "pool-01" {
  cluster_id = digitalocean_database_cluster.plant_coach_be_cluster.id
  name       = "pool-01"
  mode       = "transaction"
  size       = 5
  db_name    = var.database_name
  user       = var.backend_database_user_name
}


resource "digitalocean_database_firewall" "plant_coach_db_firewall" {
  cluster_id = digitalocean_database_cluster.plant_coach_be_cluster.id

  rule {
    type  = "k8s"
    value = digitalocean_kubernetes_cluster.plant_coach_cluster.id
  }

  rule {
    type  = "ip_addr"
    value = var.ip_address_1
  }

  # rule {
  #   type  = "droplet"
  #   value = digitalocean_kubernetes_cluster.plant_coach_cluster.node_pool[0].urn
  # }
}