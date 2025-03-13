resource "tls_private_key" "vm_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_resource_group" "production" {
  location = var.location
  name     = "${var.prefix}-resource-group"
}

resource "azurerm_virtual_network" "network" {
  address_space = ["10.0.0.0/16"]
  name                = "${var.prefix}-network"
  location            = azurerm_resource_group.production.location
  resource_group_name = azurerm_resource_group.production.name
}

resource "azurerm_subnet" "subnet" {
  address_prefixes = ["10.0.1.0/24"]
  name                 = "internal-subnet"
  resource_group_name  = azurerm_resource_group.production.name
  virtual_network_name = azurerm_virtual_network.network.name
}

resource "azurerm_public_ip" "vm_public_ip" {
  allocation_method   = "Dynamic"
  location            = azurerm_resource_group.production.location
  name                = "${var.prefix}-public-ip"
  resource_group_name = azurerm_resource_group.production.name
  sku                 = "Basic"
}

resource "azurerm_network_security_group" "network_security_group" {
  location            = azurerm_resource_group.production.location
  name                = "${var.prefix}-nsg"
  resource_group_name = azurerm_resource_group.production.name

  security_rule {
    access                     = "Allow"
    destination_address_prefix = "*"
    destination_port_range     = "22"
    direction                  = "Inbound"
    name                       = "SSH"
    priority                   = 1001
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "*"
  }
}

resource "azurerm_network_interface" "nic" {
  location            = azurerm_resource_group.production.location
  name                = "${var.prefix}-nic"
  resource_group_name = azurerm_resource_group.production.name

  ip_configuration {
    name                          = "internal-nic"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_public_ip.id
    subnet_id                     = azurerm_subnet.subnet.id
  }
}

resource "azurerm_network_interface_security_group_association" "nic_nsg_association" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.network_security_group.id
}

resource "azurerm_storage_account" "sa_boot_diagnostics" {
  account_replication_type = "LRS"
  account_tier             = "Standard"
  location                 = azurerm_resource_group.production.location
  name                     = "${var.prefix}vmdiag"
  resource_group_name      = azurerm_resource_group.production.name
}


resource "azurerm_linux_virtual_machine" "virtual_machine" {
  admin_username                  = "test-user"
  admin_password                  = "Test@12345"
  computer_name                   = "hostname"
  disable_password_authentication = false
  location                        = azurerm_resource_group.production.location
  name                            = "${var.prefix}-linux-vm"
  resource_group_name             = azurerm_resource_group.production.name
  size                            = "Standard_DS1_v2"

  network_interface_ids = [azurerm_network_interface.nic.id]

  admin_ssh_key {
    public_key = tls_private_key.vm_private_key.public_key_openssh
    username   = "test-user"
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.sa_boot_diagnostics.primary_blob_endpoint
  }

  os_disk {
    name                 = "${var.prefix}OsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    offer     = "0001-com-ubuntu-server-jammy"
    publisher = "Canonical"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}

# Create Virtual Machines inventory file for Ansible
resource "azurerm_storage_blob" "azure_vm_inventory_file" {
  name                   = "azure-vm-inventory.json"
  storage_account_name   = var.terraform_files_storage_account_name
  storage_container_name = var.terraform_files_storage_container_name
  type                   = "Block"

  source_content = jsonencode({
    vm_instances = azurerm_linux_virtual_machine.virtual_machine.*.public_ip_address
  })
}

# Create SSH key file for Ansible
resource "azurerm_storage_blob" "vm_key_file" {
  name                   = "vm_key.pem"
  storage_account_name   = var.terraform_files_storage_account_name
  storage_container_name = var.terraform_files_storage_container_name
  type                   = "Block"

  source_content = tls_private_key.vm_private_key.private_key_pem
}