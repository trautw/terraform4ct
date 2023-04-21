terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
    features {}
}

terraform {
  backend "azurerm" {
    # resource_group_name = var.resource_group_name
    resource_group_name = "ctrautwebapp1_rg"
    storage_account_name = "ctrautwebapp1sa"
    container_name = "statefile"
    # key = "${var.solution_name}_terraform.tfstate"
    key = "ctrautwebapp1_terraform.tfstate"
  }
}

module "webapp1" {
  source = "../../modules/webapp"

  resource_group_name   = var.resource_group_name
  location              = var.location
}
