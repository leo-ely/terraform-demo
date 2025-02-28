module "azure-terraform-state" {
  source                       = "./modules/tfstate"
  location                     = var.location
  tf_state_resource_group_name = var.tf_state_resource_group_name
}

module "azure-resource-group" {
  source   = "./modules/resource-group"
  location = var.location
}