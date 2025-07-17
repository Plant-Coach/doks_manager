variable "database_cluster_name" {
  description = "The name of the database cluster"
  type        = string
}

variable "postgresql_version" {
  description = "The PostgreSQL version"
  type        = string
  default     = "17"
}

variable "db_cluster_size" {
  description = "The size of the database cluster"
  type        = string
}

variable "digitalocean_database_region" {
  description = "The DigitalOcean region where the database will be created"
  type        = string
}

variable "db_cluster_node_count" {
  description = "The number of database nodes"
  type        = number
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = list(string)
  default     = []
}

variable "database_name" {
  description = "The name of the database"
  type        = string
}

variable "backend_database_user_name" {
  description = "The name of the database user"
  type        = string
}

variable "kubernetes_cluster_id" {
  description = "The ID of the Kubernetes cluster for firewall rules"
  type        = string
}

variable "allowed_ip_addresses" {
  description = "List of IP addresses allowed to access the database"
  type        = list(string)
  default     = []
}

variable "connection_pool_size" {
  description = "Size of the database connection pool"
  type        = number
  default     = 5
}
