output "nics" {
  description = "Map of created Network Interface objects."
  value       = azurerm_network_interface.this
}

output "nic_ids" {
  description = "Map of NIC keys to NIC IDs."
  value       = { for k, v in azurerm_network_interface.this : k => v.id }
}

output "private_ip_addresses" {
  description = "Map of NIC keys to assigned private IP addresses."
  value       = { for k, v in azurerm_network_interface.this : k => v.private_ip_address }
}
