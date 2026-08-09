output "nsgs" {
  description = "Map of created Network Security Group objects."
  value       = azurerm_network_security_group.this
}

output "nsg_ids" {
  description = "Map of NSG keys to NSG IDs."
  value       = { for k, v in azurerm_network_security_group.this : k => v.id }
}
