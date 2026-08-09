# Azure Infrastructure Environment Parent Modules

This directory contains the root Terraform modules for each enterprise environment (`dev`, `test`, `prod`).

## Environments Overview

| Environment | Path | Purpose | Remote State Key |
| :--- | :--- | :--- | :--- |
| **Development** | `environments/dev` | Development & feature testing sandbox. | `monolith/dev/terraform.tfstate` |
| **Testing** | `environments/test` | QA & staging integration environment. | `monolith/test/terraform.tfstate` |
| **Production** | `environments/prod` | Mission-critical production infrastructure. | `monolith/prod/terraform.tfstate` |

---

## Explicit Module Dependencies (`depends_on`)

Root environment modules instantiate reusable child modules from `modules/` using explicit `depends_on` dependency chains:

```hcl
module "resource_group" {
  source          = "../../modules/resource-group"
  resource_groups = { ... }
}

module "vnet" {
  source     = "../../modules/vnet"
  depends_on = [module.resource_group]
  vnets      = { ... }
}

module "subnet" {
  source     = "../../modules/subnet"
  depends_on = [module.vnet]
  subnets    = { ... }
}

module "nsg" {
  source     = "../../modules/nsg"
  depends_on = [module.resource_group]
  nsgs       = { ... }
}

module "nat_public_ip" {
  source     = "../../modules/public-ip"
  depends_on = [module.resource_group]
  public_ips = { ... }
}

module "nat_gateway" {
  source       = "../../modules/nat-gateway"
  depends_on   = [module.nat_public_ip, module.subnet]
  nat_gateways = { ... }
}

module "nic" {
  source     = "../../modules/nic"
  depends_on = [module.subnet, module.nsg]
  nics       = { ... }
}
```

---

## Environment Variable Files (`terraform.tfvars`)

Each environment directory configures non-secret workload variables via `terraform.tfvars`:
- `environments/dev/terraform.tfvars`
- `environments/dev/terraform.tfvars.example`
- `environments/test/terraform.tfvars.example`
- `environments/prod/terraform.tfvars.example`
