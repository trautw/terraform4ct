resource "azurerm_storage_account" "sa" {
    name            = var.Storage_Account_Name
    location            = var.location
    resource_group_name = var.ResourceGroupName
    account_tier        = "Standard"
    account_replication_type = "GRS"
    tags = var.BaseTags
}