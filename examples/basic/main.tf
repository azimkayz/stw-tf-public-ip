terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.4"
    }
  }
}

provider "azurerm" {
  features {}
}

module "public_ip" {
  source = "../../"

  project_name         = "projecta"
  environment          = "dev"
  resource_group_name  = "rg-projecta-dev-southafricanorth"
  name_suffix          = "bastion"
}

output "public_ip_id" {
  value = module.public_ip.public_ip_id
}

output "public_ip_name" {
  value = module.public_ip.public_ip_name
}