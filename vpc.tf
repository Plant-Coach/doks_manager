# https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/vpc
resource "digitalocean_vpc" "plant_coach_vpc" {
  name     = var.vpc_name
  region   = var.digitalocean_region
}

