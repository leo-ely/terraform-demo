output "terraform_files_resource_group_id" {
  value = try(
    data.azurerm_resource_group.terraform_files_rg.id
    azurerm_resource_group.terraform_resource_group[0].id
  )
}

output "terraform_files_storage_account_id" {
  value = try(
    data.azurerm_storage_account.terraform_files_sa.id,
    azurerm_storage_account.terraform_storage_account[0].id
  )
}

output "terraform_files_storage_container_id" {
  value = try(
    data.azurerm_storage_container.terraform_files_sc.id,
    azurerm_storage_container.terraform_storage_container[0].id
  )
}