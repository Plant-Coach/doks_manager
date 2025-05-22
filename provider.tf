terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.51.0"
    }
  }
}

provider "digitalocean" {
}

# Added straight from Terraform documentation.
# https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/kubernetes_cluster#kubernetes-terraform-provider-example
# data "digitalocean_kubernetes_cluster" "example" {
#   name = "plant-coach"
# }

# provider "kubernetes" {
#   host  = data.digitalocean_kubernetes_cluster.example.endpoint
#   token = data.digitalocean_kubernetes_cluster.example.kube_config[0].token
#   cluster_ca_certificate = base64decode(
#     data.digitalocean_kubernetes_cluster.example.kube_config[0].cluster_ca_certificate
#   )
# }