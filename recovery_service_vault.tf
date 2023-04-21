resource "azurerm_recovery_services_vault" "vault" {
    name                = "Terraform-recovery-vault"
    location            = var.location
    resource_group_name = var.ResourceGroupName
    sku                 = "Standard"
    tags = "${merge(tomap({ 
               MyName  = "myName"
               AutoSnapshot = "Maybe"
             }), var.BaseTags)}"
}