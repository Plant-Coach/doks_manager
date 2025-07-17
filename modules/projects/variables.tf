variable "project_name" {
  description = "The name of the DigitalOcean project"
  type        = string
}

variable "project_description" {
  description = "The description of the DigitalOcean project"
  type        = string
  default     = "Managed by Terraform"
}

variable "environment" {
  description = "The environment (e.g., development, staging, production)"
  type        = string
  default     = "development"
}

variable "cluster_urn" {
  description = "The URN of the Kubernetes cluster to assign to the project"
  type        = string
  default     = ""
}

variable "database_cluster_urn" {
  description = "The URN of the database cluster to assign to the project"
  type        = string
  default     = ""
}

variable "additional_resources" {
  description = "Additional resource URNs to assign to the project"
  type        = list(string)
  default     = []
}
