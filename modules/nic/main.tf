data "azurerm_subscription" "current" {}

resource "azurerm_network_interface" "this" {
  for_each = var.nics

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  tags                = each.value.tags

  ip_configuration {
    name = "internal"
    subnet_id = coalesce(
      each.value.subnet_id,
      "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/${each.value.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${each.value.vnet_name}/subnets/${each.value.subnet_name}"
    )
    private_ip_address_allocation = each.value.private_ip_address_allocation
  }
}

resource "azurerm_network_interface_security_group_association" "this" {
  for_each = {
    for k, v in var.nics : k => v
    if v.associate_nsg && (v.nsg_id != null || v.nsg_name != null)
  }

  network_interface_id = azurerm_network_interface.this[each.key].id
  network_security_group_id = coalesce(
    each.value.nsg_id,
    "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/${each.value.resource_group_name}/providers/Microsoft.Network/networkSecurityGroups/${each.value.nsg_name}"
  )
}
