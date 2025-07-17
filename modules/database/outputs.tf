output "cluster_id" {
  description = "The ID of the database cluster"
  value       = digitalocean_database_cluster.cluster.id
}

output "cluster_name" {
  description = "The name of the database cluster"
  value       = digitalocean_database_cluster.cluster.name
}

output "cluster_host" {
  description = "The host of the database cluster"
  value       = digitalocean_database_cluster.cluster.host
}

output "cluster_port" {
  description = "The port of the database cluster"
  value       = digitalocean_database_cluster.cluster.port
}

output "cluster_private_host" {
  description = "The private host of the database cluster"
  value       = digitalocean_database_cluster.cluster.private_host
}

output "cluster_uri" {
  description = "The URI of the database cluster"
  value       = digitalocean_database_cluster.cluster.uri
  sensitive   = true
}

output "cluster_private_uri" {
  description = "The private URI of the database cluster"
  value       = digitalocean_database_cluster.cluster.private_uri
  sensitive   = true
}

output "database_name" {
  description = "The name of the database"
  value       = digitalocean_database_db.database.name
}

output "user_name" {
  description = "The name of the database user"
  value       = digitalocean_database_user.user.name
}

output "connection_pool_name" {
  description = "The name of the connection pool"
  value       = digitalocean_database_connection_pool.pool.name
}
