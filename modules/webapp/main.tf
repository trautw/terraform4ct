variable "location" {}
variable "resource_group_name" {}

resource "azurerm_service_plan" "svcplan" {
  name        = "newweb-appserviceplan"
  location    = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_web_app" "webapp" {
    name            = "custom-tf-webapp-for-students"
    location        = var.location
    resource_group_name     = var.resource_group_name
    service_plan_id = azurerm_service_plan.svcplan.id
    # https_only            = true

    site_config {
      minimum_tls_version = "1.2"
    }
}

#  Deploy code from a public GitHub repo
resource "azurerm_app_service_source_control" "sourcecontrol" {
  app_id             = azurerm_linux_web_app.webapp.id
  # repo_url           = "https://github.com/Azure-Samples/nodejs-docs-hello-world"
  repo_url           = "https://github.com/trautw/nodejs-docs-hello-world"
  branch             = "main"
  use_manual_integration = true
  use_mercurial      = false
}

