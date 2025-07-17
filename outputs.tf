# Database resources are now managed by the database module
# See modules/database/ for the actual resources

# Outputs from modules for backward compatibility and external use
output "database_cluster_id" {
  description = "The ID of the database cluster"
  value       = module.database.cluster_id
}

output "database_cluster_name" {
  description = "The name of the database cluster"
  value       = module.database.cluster_name
}

output "database_cluster_host" {
  description = "The host of the database cluster"
  value       = module.database.cluster_host
}

output "database_cluster_port" {
  description = "The port of the database cluster"
  value       = module.database.cluster_port
}

output "database_cluster_uri" {
  description = "The URI of the database cluster"
  value       = module.database.cluster_uri
  sensitive   = true
}

output "database_name" {
  description = "The name of the database"
  value       = module.database.database_name
}

output "database_user_name" {
  description = "The name of the database user"
  value       = module.database.user_name
}

output "kubernetes_cluster_id" {
  description = "The ID of the Kubernetes cluster"
  value       = module.cluster.cluster_id
}

output "kubernetes_cluster_name" {
  description = "The name of the Kubernetes cluster"
  value       = module.cluster.cluster_name
}

output "kubernetes_cluster_endpoint" {
  description = "The endpoint of the Kubernetes cluster"
  value       = module.cluster.cluster_endpoint
}

output "project_id" {
  description = "The ID of the DigitalOcean project"
  value       = module.projects.project_id
}