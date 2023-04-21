resource "azurerm_resource_group" "rg" {
    name = var.ResourceGroupName
    # location = "germanywestcentral" # Frankfurt
    location = var.location
    tags = "${merge(tomap({ 
        Costcenter = "IT"
        Critical = "Yes"
        Environment = "Production"
        Solution = "TerraformExperiment"
        DeployedBy = "ctraut"
      }), var.BaseTags)}"
}