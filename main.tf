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
    # version = 1.38
    # use_msi = true
    # subscription_id = "f381dcb0-7ce0-427a-9d72-2a15965d07b4"
    # tenant_id = "f381dcb0-7ce0-427a-9d72-2a15965d07b4"
}

terraform {
  backend "azurerm" {
    resource_group_name = "terraformTraining"
    storage_account_name = "storage4terraform4ct"
    container_name = "statefile"
    key = "terraform.tfstate"
  }
}

module "mysqldb1" {
  source = "./modules/mysql"

  resource_group_name   = var.ResourceGroupName
  location              = var.location
}

module "webapp1" {
  source = "./modules/webapp"

  resource_group_name   = var.ResourceGroupName
  location              = var.location
}

module "vm1" {
  source = "./modules/vm"

  ResourceGroupName = var.ResourceGroupName
  location          = var.location
  subnet_id         = azurerm_subnet.tfsubnet.id 
  boot_diabnostics_blob = azurerm_storage_account.sa.primary_blob_endpoint
}