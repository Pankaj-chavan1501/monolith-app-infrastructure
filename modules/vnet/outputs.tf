output "vnets" {
  description = "Map of created Virtual Network objects."
  value       = azurerm_virtual_network.this
}

output "vnet_ids" {
  description = "Map of Virtual Network keys to VNet IDs."
  value       = { for k, v in azurerm_virtual_network.this : k => v.id }
}

output "vnet_names" {
  description = "Map of Virtual Network keys to VNet names."
  value       = { for k, v in azurerm_virtual_network.this : k => v.name }
}
