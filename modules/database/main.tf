resource "digitalocean_database_cluster" "cluster" {
  name       = var.database_cluster_name
  engine     = "pg"
  version    = var.postgresql_version
  size       = var.db_cluster_size
  region     = var.digitalocean_database_region
  node_count = var.db_cluster_node_count
  tags       = var.tags
}

resource "digitalocean_database_db" "database" {
  cluster_id = digitalocean_database_cluster.cluster.id
  name       = var.database_name
}

resource "digitalocean_database_user" "user" {
  cluster_id = digitalocean_database_cluster.cluster.id
  name       = var.backend_database_user_name
}

resource "digitalocean_database_connection_pool" "pool" {
  cluster_id = digitalocean_database_cluster.cluster.id
  name       = "pool-01"
  mode       = "transaction"
  size       = var.connection_pool_size
  db_name    = var.database_name
  user       = var.backend_database_user_name

  depends_on = [digitalocean_database_db.database, digitalocean_database_user.user]
}

resource "digitalocean_database_firewall" "firewall" {
  cluster_id = digitalocean_database_cluster.cluster.id

  rule {
    type  = "k8s"
    value = var.kubernetes_cluster_id
  }

  dynamic "rule" {
    for_each = var.allowed_ip_addresses
    content {
      type  = "ip_addr"
      value = rule.value
    }
  }
}
