data "azurerm_subnet" "tfsubnet" {
 name               = "mySubnet"   
 virtual_network_name   = "myVnet"
 resource_group_name    = var.ResourceGroupName
}

resource "azurerm_public_ip" "example" {
    name                = "pubip1"
    location            = var.location
    resource_group_name = var.ResourceGroupName
    allocation_method   = "Dynamic"
    sku                 = "Basic"
}

resource "azurerm_network_interface" "example" {
    name                = "forge-nic" # var.nic_id
    location            = var.location
    resource_group_name = var.ResourceGroupName

    ip_configuration {
        name            = "ipconfig1"
        subnet_id       = var.subnet_id 
        private_ip_address_allocation   = "Dynamic"
        public_ip_address_id            = azurerm_public_ip.example.id
    }
}
# az vm list-skus --location germanywestcentral 
resource "azurerm_virtual_machine" "example" {
    name                = "forge" # var.servername
    location            = var.location
    resource_group_name = var.ResourceGroupName
    network_interface_ids = [azurerm_network_interface.example.id]
    vm_size             = "Standard_D2s_v3" # az vm list-skus --location germanywestcentral  --output table
    delete_os_disk_on_termination = true
    delete_data_disks_on_termination = true
    storage_image_reference {
        publisher   = "canonical"
        offer       = "0001-com-ubuntu-server-focal"
        sku         = "20_04-lts-gen2"
        version     = "latest"
    }
    storage_os_disk {
        name        = "osdisk1"
        disk_size_gb    = "128"
        caching         = "ReadWrite"
        create_option   = "fromImage"
        managed_disk_type = "Standard_LRS"
    }
    os_profile {
        computer_name   = "forge"
        admin_username = "vmadmin"
        admin_password = "unsetPassword1"
    }
    os_profile_linux_config {
        disable_password_authentication = false
    }
    boot_diagnostics {
        enabled = "true"
        storage_uri = var.boot_diabnostics_blob
    }
}