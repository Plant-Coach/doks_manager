resource "digitalocean_kubernetes_cluster" "plant_coach_be_cluster" {
  name   = "plant-coach"
  region = "nyc1"
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = "1.32"

  tags = [
    "ruby",
    "rails",
    "plant-coach",
    "dev"
  ]

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-2gb"
    node_count = 1
  }
}

resource "digitalocean_database_postgresql_config" "plant_coach_be_cluster" {
  cluster_id = digitalocean_database_cluster.plant_coach_be_cluster.id
  timezone   = "UTC"
  work_mem   = 16
}

resource "digitalocean_database_cluster" "plant_coach_be_cluster" {
  name       = "plant-coach-be-cluster-postgresql-cluster"
  engine     = "pg"
  version    = "17"
  size       = "db-s-1vcpu-1gb"
  region     = "nyc1"
  node_count = 1
}