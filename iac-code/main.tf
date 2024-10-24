terraform {
  required_version = ">=1"
  cloud {
    organization = "Loot_Learn"
    workspaces {
      name = "lootlearn-iac"
    }
  }
}
module "network_module" {
  source = "./network_module"
}