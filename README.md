# terraform-azurerm-public-ip

Creates a single Azure Public IP address. The `purpose` input is folded into the resource name, which is what makes this one module reusable for both the Bastion and NAT Gateway scenarios instead of needing a module per consumer.

## Scope

**Creates**
- One `azurerm_public_ip`

**Does not create**
- The resource that attaches this IP (Bastion Host or NAT Gateway) — owned by the `bastion` and `nat-gateway` modules respectively, which each take a Public IP ID as an input rather than creating their own

## Usage

```hcl
module "bastion_pip" {
  source = "github.com/azimkayz/terraform-azurerm-public-ip?ref=v1.0.0"

  project_name         = "stw"
  environment          = "prod"
  location             = "southafricanorth"
  resource_group_name  = module.resource_group.resource_group_name
  purpose               = "bastion"
}

module "nat_pip" {
  source = "github.com/azimkayz/terraform-azurerm-public-ip?ref=v1.0.0"

  project_name         = "stw"
  environment          = "prod"
  location             = "southafricanorth"
  resource_group_name  = module.resource_group.resource_group_name
  purpose               = "nat"
}
```

A minimal, runnable example is in [`examples/basic`](./examples/basic).

## Naming

Pattern: `pip-<purpose>-<project_name>-<environment>-<location>`

Example: `pip-bastion-stw-prod-southafricanorth`

`location` is validated to accept only `southafricanorth` — no other Azure region is permitted on this platform.

## Inputs

| Name | Type | Required | Default | Description |
|---|---|---|---|---|
| `project_name` | `string` | Yes | – | Short project name used to build the Public IP name. |
| `environment` | `string` | Yes | – | Environment name, e.g. `dev`, `test`, `prod`. |
| `location` | `string` | No | `"southafricanorth"` | Azure region. Validated to reject every value except `southafricanorth`. |
| `resource_group_name` | `string` | Yes | – | Resource group the Public IP is deployed into. |
| `purpose` | `string` | Yes | – | What this IP is used for, e.g. `"bastion"` or `"nat"`. Folded into the resource name — this is what makes the module reusable across consumers. |
| `allocation_method` | `string` | No | `"Static"` | `Static` or `Dynamic`. |
| `sku` | `string` | No | `"Standard"` | `Basic` or `Standard`. |
| `zones` | `list(string)` | No | `null` | Optional availability zones. |
| `tags` | `map(string)` | No | `{}` | Common tags applied to the Public IP. |

## Outputs

| Name | Description | Consumed by |
|---|---|---|
| `public_ip_id` | Resource ID of the Public IP. | `bastion` module (`bastion_public_ip_id`) and `nat-gateway` module (`nat_public_ip_id`). |
| `public_ip_name` | Name of the Public IP. | Not currently consumed by another module; available for diagnostics or documentation. |
| `public_ip_address` | The allocated IP address. | Not currently consumed by another module; useful for firewall allow-lists or DNS records outside this platform. |

## Requirements

| Name | Version |
|---|---|
| Terraform | `>= 1.5.0` |
| azurerm provider | `~> 3.90` |

## Versioning

Only tagged releases are supported for consumption — always pin `?ref=vX.Y.Z` in the `source` argument. `main` is not a supported consumption target and may change without notice.
