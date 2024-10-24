terraform {
  required_version = ">= 1.1.2"
  cloud {
    organization = "Vicdonxp"
    workspaces {
      name = "lootlearn-iac"
    }
  }
}