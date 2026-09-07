# stw-tf-public-ip

Single-responsibility Terraform module that creates an Azure Public IP address.

## Scope

Creates only the Public IP resource. Deliberately built to be reusable — the
same module gets called twice in `stw-infra-live`: once for the Bastion
Host, once for the NAT Gateway. Each caller passes a distinct `name_suffix`
so the two IPs don't collide on name.

## Naming — worked example

project_name = "projecta", environment = "prod":

- `name_suffix = "bastion"` → `pip-bastion-projecta-prod-southafricanorth`
- `name_suffix = "nat"` → `pip-nat-projecta-prod-southafricanorth`

## Usage

```hcl
module "bastion_public_ip" {
  source = "github.com/azimkayz/stw-tf-public-ip?ref=v1.0.0"

  project_name         = "projecta"
  environment          = "prod"
  resource_group_name  = module.resource_group.resource_group_name
  name_suffix          = "bastion"
}

module "nat_public_ip" {
  source = "github.com/azimkayz/stw-tf-public-ip?ref=v1.0.0"

  project_name         = "projecta"
  environment          = "prod"
  resource_group_name  = module.resource_group.resource_group_name
  name_suffix          = "nat"
}
```

## Requirements

| Name      | Version  |
|-----------|----------|
| terraform | >= 1.5.0 |
| azurerm   | ~> 3.0   |

## Inputs

| Name                 | Type        | Default          | Required | Description                       |
|----------------------|-------------|------------------|----------|-------------------------------------|
| project_name         | string      | n/a              | yes      | Short project identifier for naming |
| environment          | string      | n/a              | yes      | Environment name for naming         |
| location             | string      | southafricanorth | no       | Azure region (validated)            |
| resource_group_name  | string      | n/a              | yes      | Existing resource group             |
| name_suffix          | string      | n/a              | yes      | Purpose suffix, e.g. 'bastion' or 'nat' |
| allocation_method    | string      | Static           | no       | Static or Dynamic                   |
| sku                  | string      | Standard         | no       | Basic or Standard                   |
| tags                 | map(string) | {}               | no       | Additional tags                     |

## Outputs

| Name           | Description                                        |
|----------------|-------------------------------------------------------|
| public_ip_id   | Resource ID — consumed by Bastion or NAT Gateway module |
| public_ip_name | Generated name of the Public IP                         |

## Versioning

Tagged `v1.0.0`. Consumers should pin to a tag, not a branch.