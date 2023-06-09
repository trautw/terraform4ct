terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
    features {}
}

terraform {
  backend "azurerm" {
    resource_group_name = "terraformTraining"
    storage_account_name = "storage4terraform4ct"
    container_name = "statefile"
    key = "terraform-func-dev.tfstate"
  }
}

resource "azurerm_resource_group" "resource_group" {
  name = "${var.project}-${var.environment}-rg"
  location = var.location
}

resource "azurerm_storage_account" "storage_account" {
  name = "chtw2${var.project}${var.environment}storage"
  resource_group_name = azurerm_resource_group.resource_group.name
  location = var.location
  account_tier = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_application_insights" "application_insights" {
  name                = "${var.project}-${var.environment}-application-insights"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name
  application_type    = "Node.JS"
}

resource "azurerm_service_plan" "app_service_plan" {
  name                = "${var.project}-${var.environment}-service-plan"
  location    = var.location
  resource_group_name = azurerm_resource_group.resource_group.name
  os_type             = "Linux"
  sku_name            = "Y1"
}

# See also https://github.com/data-platform-hq/terraform-azurerm-function-app-linux/blob/main/main.tf
resource "azurerm_linux_function_app" "function_app" {
  name                       = "${var.project}-${var.environment}-function-app"
  resource_group_name        = azurerm_resource_group.resource_group.name
  location                   = var.location
  service_plan_id            = azurerm_service_plan.app_service_plan.id
  app_settings = {
    # "WEBSITE_RUN_FROM_PACKAGE" = "",
    "FUNCTIONS_WORKER_RUNTIME" = "node",
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.application_insights.instrumentation_key,
  }
  # os_type = "linux"
  site_config {
    application_stack {
      node_version          = "18"
    }
    # linux_fx_version          = "node|14"
    # use_32_bit_worker_process = false
  }
  storage_account_name       = azurerm_storage_account.storage_account.name
  storage_account_access_key = azurerm_storage_account.storage_account.primary_access_key
  # version                    = "~3"

  lifecycle {
    ignore_changes = [
      app_settings["WEBSITE_RUN_FROM_PACKAGE"],
    ]
  }
}