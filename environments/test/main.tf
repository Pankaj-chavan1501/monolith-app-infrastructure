module "resource_group" {
  source = "../../modules/resource-group"

  workload_name = var.workload_name
  environment   = var.environment
  location      = var.location
  instance      = var.instance
  tags          = var.tags
}
