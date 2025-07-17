output "project_id" {
  description = "The ID of the DigitalOcean project"
  value       = digitalocean_project.project.id
}

output "project_name" {
  description = "The name of the DigitalOcean project"
  value       = digitalocean_project.project.name
}

output "project_description" {
  description = "The description of the DigitalOcean project"
  value       = digitalocean_project.project.description
}

output "project_environment" {
  description = "The environment of the DigitalOcean project"
  value       = digitalocean_project.project.environment
}
