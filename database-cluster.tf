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

  # ToDo: https://github.com/Plant-Coach/doks_manager/issues/6
  # rule {
  #   type  = "droplet"
  #   value = digitalocean_kubernetes_cluster.plant_coach_cluster.node_pool[0].urn
  # }
}