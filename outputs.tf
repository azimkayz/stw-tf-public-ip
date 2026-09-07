output "public_ip_id" {
  value       = azurerm_public_ip.this.id
  description = "The resource ID of the Public IP. Consumed by whichever module attaches it (Bastion or NAT Gateway)."
}

output "public_ip_name" {
  value       = azurerm_public_ip.this.name
  description = "The generated name of the Public IP."
}