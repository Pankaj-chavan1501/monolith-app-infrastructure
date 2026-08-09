output "public_ips" {
  description = "Map of created Public IP objects."
  value       = azurerm_public_ip.this
}

output "public_ip_ids" {
  description = "Map of Public IP keys to Public IP IDs."
  value       = { for k, v in azurerm_public_ip.this : k => v.id }
}

output "public_ip_addresses" {
  description = "Map of Public IP keys to allocated IP addresses."
  value       = { for k, v in azurerm_public_ip.this : k => v.ip_address }
}
