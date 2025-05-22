terraform {
  cloud {

    organization = "plant-coach"

    workspaces {
      name = "do-k8s"
    }
  }
}