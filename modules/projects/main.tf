resource "digitalocean_project" "project" {
  name        = var.project_name
  description = var.project_description
  purpose     = "Web Application"
  environment = var.environment

  resources = compact(concat([
    var.cluster_urn,
    var.database_cluster_urn
  ], var.additional_resources))
}
