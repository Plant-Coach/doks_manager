# Cluster Module

This module creates a DigitalOcean Kubernetes cluster with a worker node pool.

## Usage

```hcl
module "cluster" {
  source = "./modules/cluster"

  app_name             = "my-app"
  digitalocean_region  = "nyc1"
  k8s_version         = "1.32"
  node_pool_size      = "s-2vcpu-2gb"
  node_count          = "2"
  tags                = ["terraform", "kubernetes"]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app_name | The name of the application | `string` | n/a | yes |
| digitalocean_region | The DigitalOcean region where the cluster will be created | `string` | n/a | yes |
| k8s_version | The Kubernetes version | `string` | `"1.32"` | no |
| node_pool_size | The size of the worker nodes | `string` | n/a | yes |
| node_count | The number of worker nodes | `string` | n/a | yes |
| tags | Tags to apply to resources | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster_id | The ID of the Kubernetes cluster |
| cluster_name | The name of the Kubernetes cluster |
| cluster_endpoint | The endpoint of the Kubernetes cluster |
| cluster_region | The region of the Kubernetes cluster |
| cluster_status | The status of the Kubernetes cluster |
