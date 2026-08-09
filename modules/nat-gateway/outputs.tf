output "nat_gateways" {
  description = "Map of created NAT Gateway objects."
  value       = azurerm_nat_gateway.this
}

output "nat_gateway_ids" {
  description = "Map of NAT Gateway keys to NAT Gateway IDs."
  value       = { for k, v in azurerm_nat_gateway.this : k => v.id }
}
