data "azurerm_subscription" "current" {}

resource "azurerm_nat_gateway" "this" {
  for_each = var.nat_gateways

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku_name            = each.value.sku_name
  tags                = each.value.tags
}

resource "azurerm_nat_gateway_public_ip_association" "this" {
  for_each = var.nat_gateways

  nat_gateway_id = azurerm_nat_gateway.this[each.key].id
  public_ip_address_id = coalesce(
    each.value.public_ip_id,
    "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/${each.value.resource_group_name}/providers/Microsoft.Network/publicIPAddresses/${each.value.public_ip_name}"
  )
}

resource "azurerm_subnet_nat_gateway_association" "this" {
  for_each = {
    for k, v in var.nat_gateways : k => v
    if v.subnet_name != null || length(v.subnet_ids) > 0
  }

  subnet_id = coalesce(
    lookup(each.value.subnet_ids, each.key, null),
    "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/${each.value.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${each.value.vnet_name}/subnets/${each.value.subnet_name}"
  )
  nat_gateway_id = azurerm_nat_gateway.this[each.key].id
}
