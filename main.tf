resource "azurerm_resource_group" "example1" {
  name     = var.resource_group_name
  location = var.location
}
resource "azurerm_virtual_network" "example1" {
  name                = "${var.vm_name}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example1.location
  resource_group_name = azurerm_resource_group.example1.name
}
resource "azurerm_subnet" "example1" {
  name                 = "${var.vm_name}-subnet"
  resource_group_name  = azurerm_resource_group.example1.name
  virtual_network_name = azurerm_virtual_network.example1.name
  address_prefixes     = ["10.0.1.0/24"]
}
resource "azurerm_public_ip" "example1" {
  name                = "${var.vm_name}-publicip"
  location            = azurerm_resource_group.example1.location
  resource_group_name = azurerm_resource_group.example1.name
  allocation_method   = "Dynamic"
}
# Create a network interface for the VM
resource "azurerm_network_interface" "example1" {
  name                      = "${var.vm_name}-nic"
  location                  = azurerm_resource_group.example1.location
  resource_group_name       = azurerm_resource_group.example1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.example1.id
  }
}
resource "azurerm_virtual_machine" "example1" {
  name                  = var.vm_name
  location              = azurerm_resource_group.example1.location
  resource_group_name   = azurerm_resource_group.example1.name
  network_interface_ids = [azurerm_network_interface.example1.id]

  vm_size               = var.vm_size

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.vm_name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  os_profile {
    computer_name  = var.vm_name
    admin_username = var.vm_username
    admin_password = var.vm_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    environment = "production"
  }
}
