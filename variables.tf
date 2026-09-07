variable "project_name" {
  type        = string
  description = "Short project identifier used in resource naming, e.g. 'projecta'."
}

variable "environment" {
  type        = string
  description = "Environment name used in resource naming, e.g. 'dev', 'test', 'prod'."
}

variable "location" {
  type        = string
  default     = "southafricanorth"
  description = "Azure region to deploy into."

  validation {
    condition     = var.location == "southafricanorth"
    error_message = "Only 'southafricanorth' is permitted as the deployment region for this project."
  }
}

variable "resource_group_name" {
  type        = string
  description = "Name of the existing resource group to deploy into."
}

variable "name_suffix" {
  type        = string
  description = "Purpose suffix distinguishing this Public IP's consumer, e.g. 'bastion' or 'nat'. Required so calling this module twice produces two differently-named IPs."
}

variable "allocation_method" {
  type        = string
  default     = "Static"
  description = "Allocation method for the Public IP. Bastion and NAT Gateway both require Static."
}

variable "sku" {
  type        = string
  default     = "Standard"
  description = "SKU for the Public IP. Bastion and NAT Gateway both require Standard."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Optional tags to apply to the Public IP."
}