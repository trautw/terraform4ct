variable "location" {}
variable "resource_group_name" {}

resource "azurerm_mysql_server" "mys" {
    name        = "mysql-tfserver-1"
    location    = var.location
    resource_group_name     = var.resource_group_name

    administrator_login     = "mysqladmin"
    administrator_login_password = "wZ6jbaYcSkN8wA."
    version                         = "5.7"
    sku_name                        = "B_Gen5_2"
    ssl_enforcement_enabled         = "true"
}

resource "azurerm_mysql_database" "dbexample" {
    name        = "mysqldb1"
    resource_group_name     = var.resource_group_name
    server_name             = azurerm_mysql_server.mys.name
    charset                 = "utf8"
    collation               = "utf8_unicode_ci"
}