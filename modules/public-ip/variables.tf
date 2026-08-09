variable "public_ips" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    allocation_method   = optional(string, "Static")
    sku                 = optional(string, "Standard")
    tags                = optional(map(string), {})
  }))
  description = "Map of Public IPs to provision."
}
