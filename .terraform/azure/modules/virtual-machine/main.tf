resource "azurerm_resource_group" "production" {
  location = var.location
  name     = "${var.prefix}-resource-group"
}

resource "azurerm_virtual_network" "network" {
  address_space = ["10.0.0.0/22"]
  name                = "${var.prefix}-network"
  location            = azurerm_resource_group.production.location
  resource_group_name = azurerm_resource_group.production.name
}

resource "azurerm_subnet" "subnet" {
  address_prefixes = ["10.0.2.0/24"]
  name                 = "internal-subnet"
  resource_group_name  = azurerm_resource_group.production.name
  virtual_network_name = azurerm_virtual_network.network.name
}

resource "azurerm_network_interface" "nic" {
  location            = azurerm_resource_group.production.location
  name                = "${var.prefix}-nic"
  resource_group_name = azurerm_resource_group.production.name

  ip_configuration {
    name                          = "internal-nic"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.subnet.id
  }
}

resource "azurerm_linux_virtual_machine" "virtual_machine" {
  admin_username                  = "test-user"
  admin_password                  = "Test@12345"
  disable_password_authentication = false
  location                        = "eastus"
  name                            = "${var.prefix}-linux-vm"
  resource_group_name             = azurerm_resource_group.production.name
  size                            = "Standard_D2s_v3"

  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    offer     = "UbuntuServer"
    publisher = "Canonical"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

resource "azurerm_storage_blob" "azure_vm_inventory_file" {
  name                   = "azure-vm-inventory.json"
  storage_account_name   = var.terraform_files_storage_account_name
  storage_container_name = var.terraform_files_storage_container_name
  type                   = "Block"

  source_content = jsonencode({
    vm_instances = azurerm_linux_virtual_machine.virtual_machine.*.public_ip_address
  })
}