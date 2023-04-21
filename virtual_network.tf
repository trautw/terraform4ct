resource "azurerm_virtual_network" "myterraformnetwork" {
    name                = "myVnet"
    address_space       = ["10.0.0.0/16"]
    location            = var.location
    resource_group_name = var.ResourceGroupName
}

resource "azurerm_subnet" "tfsubnet" {
    name                    = "mySubnet"
    resource_group_name     = var.ResourceGroupName
    virtual_network_name    = azurerm_virtual_network.myterraformnetwork.name
    address_prefixes        = ["10.0.1.0/24"]
}
resource "azurerm_subnet" "tfsubnet2" {
    name                    = "mySubnet2"
    resource_group_name     = var.ResourceGroupName
    virtual_network_name    = azurerm_virtual_network.myterraformnetwork.name
    address_prefixes        = ["10.0.2.0/24"]
}