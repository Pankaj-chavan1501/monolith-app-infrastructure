module "resource_group" {
  source          = "../../modules/resource-group"
  resource_groups = var.resource_groups
}

module "vnet" {
  source     = "../../modules/vnet"
  depends_on = [module.resource_group]
  vnets      = var.vnets
}

module "subnet" {
  source     = "../../modules/subnet"
  depends_on = [module.vnet]
  subnets    = var.subnets
}

module "nsg" {
  source     = "../../modules/nsg"
  depends_on = [module.resource_group]
  nsgs       = var.nsgs
}

module "nat_public_ip" {
  source     = "../../modules/public-ip"
  depends_on = [module.resource_group]
  public_ips = var.public_ips
}

module "nat_gateway" {
  source       = "../../modules/nat-gateway"
  depends_on   = [module.nat_public_ip, module.subnet]
  nat_gateways = var.nat_gateways
}

module "nic" {
  source     = "../../modules/nic"
  depends_on = [module.subnet, module.nsg]
  nics       = var.nics
}
