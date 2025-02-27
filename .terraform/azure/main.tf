module "azure-resource-group" {
  source   = "./modules/resource-group"
  location = var.location
}