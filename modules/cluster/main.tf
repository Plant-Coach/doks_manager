resource "digitalocean_kubernetes_cluster" "cluster" {
  name   = var.app_name
  region = var.digitalocean_region
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = var.k8s_version

  tags = var.tags

  node_pool {
    name       = "${var.app_name}-worker-pool"
    size       = var.node_pool_size
    node_count = var.node_count
    tags       = var.tags
  }
}
