variable "nics" {
  type = map(object({
    name                          = string
    location                      = string
    resource_group_name           = string
    vnet_name                     = optional(string, null)
    subnet_name                   = optional(string, null)
    subnet_id                     = optional(string, null)
    nsg_name                      = optional(string, null)
    nsg_id                        = optional(string, null)
    associate_nsg                 = optional(bool, true)
    private_ip_address_allocation = optional(string, "Dynamic")
    tags                          = optional(map(string), {})
  }))
  description = "Map of Network Interfaces to provision."
}
