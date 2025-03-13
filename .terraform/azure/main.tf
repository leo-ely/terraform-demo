module "azure_virtual_machine" {
  source                                 = "./modules/virtual-machine"
  location                               = var.location
  terraform_files_storage_account_name   = local.terraform_files_storage_account_name
  terraform_files_storage_container_name = local.terraform_files_storage_container_name
}