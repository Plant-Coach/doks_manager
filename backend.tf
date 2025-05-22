terraform {
  cloud {

    organization = var.terraform_cloud_organization

    workspaces {
      name = var.terraform_cloud_workspace
    }
  }
}