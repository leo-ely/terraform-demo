resource "random_string" "resource_code" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_resource_group" "tfstate" {
  location = var.location
  name     = var.tf_state_resource_group_name
}

resource "azurerm_storage_account" "tfstate" {
  account_replication_type        = "LRS"
  account_tier                    = "Standard"
  allow_nested_items_to_be_public = false
  location                        = var.location
  name                            = "${var.tf_state_resource_group_name}${random_string.resource_code.result}"
  resource_group_name             = var.tf_state_resource_group_name
  tags = {
    environment = "production"
  }
}

resource "azurerm_storage_container" "tfstate" {
  container_access_type = "private"
  name                  = var.tf_state_resource_group_name
  storage_account_id    = azurerm_storage_account.tfstate.id
}