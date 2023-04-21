variable "solution_name" {
    default = "ctrautwebapp1"
}

variable "location" {
    description = "Azure Region."
    # default = "germanywestcentral"
    default = "westeurope"
}
variable "resource_group_name" {
    description = "Please enter the resource group for the storage account."
    # default = "${var.solution_name}_rg"
    default = "ctrautwebapp1_rg"
}

variable "BaseTags" {
    default = {
        Solution = "ctrautwebapp1"
        Environment = "Dev"
        CreatedBy = "TF Admin"
        Costcenter = "IT"
        Critical = "Yes"
    }
}