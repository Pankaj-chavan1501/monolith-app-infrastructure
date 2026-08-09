resource "azurerm_network_security_group" "this" {
  for_each = var.nsgs

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  tags                = each.value.tags
}

locals {
  nsg_rules = flatten([
    for nsg_key, nsg in var.nsgs : [
      for rule_key, rule in nsg.security_rules : {
        composite_key              = "${nsg_key}_${rule_key}"
        nsg_name                   = azurerm_network_security_group.this[nsg_key].name
        rule_name                  = rule_key
        resource_group_name        = nsg.resource_group_name
        priority                   = rule.priority
        direction                  = rule.direction
        access                     = rule.access
        protocol                   = rule.protocol
        source_port_range          = rule.source_port_range
        destination_port_range     = rule.destination_port_range
        source_address_prefix      = rule.source_address_prefix
        destination_address_prefix = rule.destination_address_prefix
        description                = rule.description
      }
    ]
  ])
}

resource "azurerm_network_security_rule" "this" {
  for_each = { for r in local.nsg_rules : r.composite_key => r }

  name                        = each.value.rule_name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  description                 = each.value.description
  resource_group_name         = each.value.resource_group_name
  network_security_group_name = each.value.nsg_name
}
