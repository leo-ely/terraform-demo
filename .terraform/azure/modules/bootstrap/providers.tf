provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
  use_oidc                        = true
}