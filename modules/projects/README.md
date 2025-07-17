# Projects Module

This module creates a DigitalOcean project and assigns resources to it for better organization and management.

## Usage

```hcl
module "projects" {
  source = "./modules/projects"

  project_name        = "my-project"
  project_description = "My web application project"
  environment         = "development"
  cluster_urn         = module.cluster.cluster_id
  database_cluster_urn = module.database.cluster_id
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project_name | The name of the DigitalOcean project | `string` | n/a | yes |
| project_description | The description of the DigitalOcean project | `string` | `"Managed by Terraform"` | no |
| environment | The environment (e.g., development, staging, production) | `string` | `"development"` | no |
| cluster_urn | The URN of the Kubernetes cluster to assign to the project | `string` | `""` | no |
| database_cluster_urn | The URN of the database cluster to assign to the project | `string` | `""` | no |
| additional_resources | Additional resource URNs to assign to the project | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| project_id | The ID of the DigitalOcean project |
| project_name | The name of the DigitalOcean project |
| project_description | The description of the DigitalOcean project |
| project_environment | The environment of the DigitalOcean project |
