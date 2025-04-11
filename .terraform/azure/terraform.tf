terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.7.0"
    }
  }

  required_version = "~>1.11.0"

  backend "azurerm" {}
}