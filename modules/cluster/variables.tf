variable "app_name" {
  description = "The name of the application"
  type        = string
}

variable "digitalocean_region" {
  description = "The DigitalOcean region where the cluster will be created"
  type        = string
}

variable "k8s_version" {
  description = "The Kubernetes version"
  type        = string
  default     = "1.32"
}

variable "node_pool_size" {
  description = "The size of the worker nodes"
  type        = string
}

variable "node_count" {
  description = "The number of worker nodes"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = list(string)
  default     = []
}
