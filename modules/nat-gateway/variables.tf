variable "nat_gateways" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    public_ip_name      = optional(string, null)
    public_ip_id        = optional(string, null)
    vnet_name           = optional(string, null)
    subnet_name         = optional(string, null)
    subnet_ids          = optional(map(string), {})
    sku_name            = optional(string, "Standard")
    tags                = optional(map(string), {})
  }))
  description = "Map of NAT Gateways to provision."
}
