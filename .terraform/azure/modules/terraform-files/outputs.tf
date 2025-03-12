output "terraform_files_resource_group_id" {
  value = azurerm_resource_group.terraform_resource_group.id
}

output "terraform_files_storage_account_id" {
  value = azurerm_storage_account.terraform_storage_account.id
}

output "terraform_files_storage_container_id" {
  value = azurerm_storage_container.terraform_storage_container.id
}