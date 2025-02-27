resource "azurerm_resource_group" "azure-resource-group" {
  location = var.location
  name     = "terraform-azure-resource-group-demo"
}