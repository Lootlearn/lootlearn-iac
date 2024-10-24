provider "aws" {
  region = var.region
  access_key = var.aws_access_id
  secret_key = var.aws_access_key
}
terraform {
  required_version = ">=1"
  cloud {
    organization = "Loot_Learn"
    workspaces {
      name = "lootlearn-iac"
    }
  }
}