variable "container" {
    description = "Enter container name"
    default     = "blobcontainer"
}

resource "azurerm_storage_container" "lab" {
  name                  = var.container
  storage_account_name  = var.Storage_Account_Name
  container_access_type   = "private"
}

resource "azurerm_storage_blob" "lab" {
    name                    = "terraformBlob"
    storage_account_name    = azurerm_storage_account.sa.name
    storage_container_name  = azurerm_storage_container.lab.name
    type                    = "Block"
}

resource "azurerm_storage_share" "lab" {
    name                    = "terraformshare"
    storage_account_name    = azurerm_storage_account.sa.name
    quota                   = 50
}