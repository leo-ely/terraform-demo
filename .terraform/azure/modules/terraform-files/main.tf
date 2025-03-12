resource "azurerm_storage_account" "terraform_storage_account" {
  account_replication_type = "LRS"
  account_tier             = "Standard"
  location                 = var.location
  name                     = "actionsterraformstorage"
  resource_group_name      = "terraform-resource-group"
}

resource "azurerm_storage_container" "terraform_storage_container" {
  container_access_type = "private"
  name                  = "terraform-files"
  storage_account_id    = azurerm_storage_account.terraform_storage_account.id
}