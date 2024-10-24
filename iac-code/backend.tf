terraform {
  required_version = ">= 1.1.2"
  cloud {
    organization = "Loot_Learn"
    workspaces {
      name = "lootlearn-iac"
    }
  }
}