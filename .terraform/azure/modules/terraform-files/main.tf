resource "azurerm_resource_group" "terraform" {
  location = var.location
  name     = "terraform-resource-group"
}

resource "azurerm_storage_account" "terraform" {
  account_replication_type = "LRS"
  account_tier             = "Standard"
  location                 = azurerm_resource_group.terraform.location
  name                     = "actionsterraformstorage"
  resource_group_name      = azurerm_resource_group.terraform.name
}

resource "azurerm_storage_container" "terraform" {
  container_access_type = "private"
  name                  = "terraform-files"
  storage_account_id    = azurerm_storage_account.terraform.id
}

output "terraform_files_resource_group_id" {
  value = azurerm_resource_group.terraform.id
}

output "terraform_files_storage_account_id" {
  value = azurerm_storage_account.terraform.id
}

output "terraform_files_storage_container_id" {
  value = azurerm_storage_container.terraform.id
}