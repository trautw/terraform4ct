variable "azure_dns_zone" {
    default = "chtw.de"
}

variable "subdomain" {
    default = "func"
}

resource "azurerm_dns_zone" "dns-zone" {
  name                = var.azure_dns_zone
  resource_group_name = azurerm_resource_group.resource_group.name
}

resource "azurerm_dns_txt_record" "domain-verification" {
  name                = "asuid.${var.subdomain}.${var.azure_dns_zone}"
  zone_name           = var.azure_dns_zone
  resource_group_name = azurerm_resource_group.resource_group.name
  ttl                 = 300

  record {
    value = azurerm_linux_function_app.function_app.custom_domain_verification_id
  }
}

resource "azurerm_dns_cname_record" "cname-record" {
  name                = var.azure_dns_zone
  zone_name           = azurerm_dns_zone.dns-zone.name
  resource_group_name = azurerm_resource_group.resource_group.name
  ttl                 = 300
  record              = azurerm_linux_function_app.function_app.default_hostname

  depends_on = [azurerm_dns_txt_record.domain-verification]
}

resource "azurerm_app_service_custom_hostname_binding" "hostname-binding" {
  resource_group_name = azurerm_resource_group.resource_group.name
  hostname            = "${var.subdomain}.${var.azure_dns_zone}"
  app_service_name    = azurerm_linux_function_app.function_app.name

  depends_on = [azurerm_dns_cname_record.cname-record]
}

resource "azurerm_app_service_managed_certificate" "managed-certificate" {
  custom_hostname_binding_id = azurerm_app_service_custom_hostname_binding.hostname-binding.id
}

resource "azurerm_app_service_certificate_binding" "certificate-binding" {
  hostname_binding_id = azurerm_app_service_custom_hostname_binding.hostname-binding.id
  certificate_id      = azurerm_app_service_managed_certificate.managed-certificate.id
  ssl_state           = "SniEnabled"
}