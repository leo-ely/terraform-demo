# Sources for hosting Terraform's state file
module "terraform-files" {
  source   = "./modules/terraform-files"
  location = var.location
}

module "azure-virtual-machine" {
  source                               = "./modules/virtual-machine"
  location                             = var.location
  terraform_files_resource_group_id    = module.terraform-files.terraform_files_resource_group_id
  terraform_files_storage_account_id   = module.terraform-files.terraform_files_storage_account_id
  terraform_files_storage_container_id = module.terraform-files.terraform_files_storage_container_id
}