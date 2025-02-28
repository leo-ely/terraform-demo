provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
  use_oidc                        = true
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.7.0"
    }
  }

  backend "azurerm" {}
}