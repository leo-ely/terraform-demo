# Sources for hosting Terraform's state file
module "terraform_files" {
  source   = "./modules/terraform-files"
  location = var.location
}

module "azure_virtual_machine" {
  source                                 = "./modules/virtual-machine"
  location                               = var.location
  terraform_files_storage_account_name   = module.terraform_files.terraform_files_storage_account_name
  terraform_files_storage_container_name = module.terraform_files.terraform_files_storage_container_name
}