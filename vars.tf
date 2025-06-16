# The variables represented here are maintainable in this 
# workspace's Terraform variables for security and reusability.
# DO NOT change these variable names without also updating
# the Terraform Cloud workspace variables.
variable "backend_database_user_name" {
  type    = string
  default = "backend_database_user_name"
}

variable "terraform_cloud_organization" {
  type = string
  default = "terraform_cloud_organization"
}

variable "terraform_cloud_workspace" {
  type = string
  default = "terraform_cloud_workspace"
}

variable "database_name" {
  type    = string
  default = "database_name"
}

variable "database_cluster_name" {
  type    = string
  default = "database_cluster_name"
}

variable "app_name" {
  type    = string
  default = "app_name"
}

variable "project_name" {
  type    = string
  default = "project_name"
}

variable "project_description" {
  type    = string
  default = "Demo Web Application"
}

# Reference: https://slugs.do-api.dev
variable "node_pool_size" {
  type    = string
  default = "s-2vcpu-2gb"
}

variable "node_count" {
  type    = string
  default = "1"
}

# Reference: https://slugs.do-api.dev
variable "db_cluster_size" {
  type    = string
  default = "db-s-1vcpu-1gb"
}

variable "db_cluster_node_count" {
  type    = number
  default = 1
}

variable "environment" {
  type    = string
  default = "development"
}

variable "ip_address_1" {
  sensitive   = true
  description = "A user-specified IP address that is whitelisted for DB access."
  type        = string
  default     = "ip_address_1"
}

variable "digitalocean_database_region" {
  type    = string
  default = "nyc1"
}

variable "digitalocean_region" {
  type    = string
  default = "nyc1"
}

variable "vpc_name" {
  type = string
  default = "my_new_vpc"
}

variable "vpc_ip_range" {
  type = string
  default = "10.10.10.0/20"
}

# This will require more implementation from a module perspective.
variable "ip_address_2" {
  sensitive   = true
  description = "A user-specified IP address that is whitelisted for DB access."
  type        = string
  default     = "ip_address_2"
}