terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.51.0"
    }
  }
}

provider "digitalocean" {
  token = "dop_v1_592de439fe92c612c88cedc7813b9c290710e45dec8f1975d41c9bc8061b4a08"
}