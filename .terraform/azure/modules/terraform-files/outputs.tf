output "terraform_files_resource_group_name" {
  value = azurerm_storage_account.terraform_storage_account.resource_group_name
}

output "terraform_files_storage_account_name" {
  value = azurerm_storage_account.terraform_storage_account.name
}

output "terraform_files_storage_container_name" {
  value = azurerm_storage_container.terraform_storage_container.name
}