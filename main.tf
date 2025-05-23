locals {
  tags = [
    "ruby",
    "rails",
    "plant-coach",
    "dev",
    "terraform",
    "terraform-cloud"
  ]
  k8s_version          = "1.32"
  postgresql_version   = "17"
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
    tags       = local.tags
  }
}