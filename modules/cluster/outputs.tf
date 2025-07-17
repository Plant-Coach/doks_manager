output "cluster_id" {
  description = "The ID of the Kubernetes cluster"
  value       = digitalocean_kubernetes_cluster.cluster.id
}

output "cluster_name" {
  description = "The name of the Kubernetes cluster"
  value       = digitalocean_kubernetes_cluster.cluster.name
}

output "cluster_endpoint" {
  description = "The endpoint of the Kubernetes cluster"
  value       = digitalocean_kubernetes_cluster.cluster.endpoint
}

output "cluster_region" {
  description = "The region of the Kubernetes cluster"
  value       = digitalocean_kubernetes_cluster.cluster.region
}

output "cluster_status" {
  description = "The status of the Kubernetes cluster"
  value       = digitalocean_kubernetes_cluster.cluster.status
}
