variable "location" {
    description = "Azure Region."
    # default = "germanywestcentral"
    default = "westeurope"
}
variable "ResourceGroupName" {
    description = "Please enter the resource group for the storage account."
    default = "TFResourceGroup"
}
variable "Storage_Account_Name" {
    description = "Please enter unique name for this storage account."
    default = "sauniquename4video"
}
variable "BaseTags" {
    default = {
        Solution = "TerraformExperiments"
        Environment = "Production"
        CreatedBy = "TF Admin"
        Costcenter = "IT"
        Critical = "Yes"
    }
}