data "azurerm_resource_group" "terraform_files_rg" {
  name = "terraform-resource-group"
}

data "azurerm_storage_account" "terraform_files_sa" {
  name = "actionsterraformstorage"
  resource_group_name = try(
    data.azurerm_resource_group.terraform_files_rg.name,
    "terraform-resource-group"
  )
}

data "azurerm_storage_container" "terraform_files_sc" {
  name = "terraform-files"
  storage_account_id = try(data.azurerm_storage_account.terraform_files_sa.id, null)
}

resource "azurerm_resource_group" "terraform_resource_group" {
  count    = try(data.azurerm_resource_group.terraform_files_rg.id, null) == null ? 1 : 0
  location = var.location
  name     = "terraform-resource-group"
}

resource "azurerm_storage_account" "terraform_storage_account" {
  count                    = try(data.azurerm_storage_account.terraform_files_sa.id, null) == null ? 1 : 0
  account_replication_type = "LRS"
  account_tier             = "Standard"
  location                 = azurerm_resource_group.terraform_resource_group.location
  name                     = "actionsterraformstorage"
  resource_group_name      = azurerm_resource_group.terraform_resource_group.name
}

resource "azurerm_storage_container" "terraform_storage_container" {
  count                 = try(data.azurerm_storage_container.terraform_files_sc.id, null) == null ? 1 : 0
  container_access_type = "private"
  name                  = "terraform-files"
  storage_account_id    = azurerm_storage_account.terraform_storage_account.id
}