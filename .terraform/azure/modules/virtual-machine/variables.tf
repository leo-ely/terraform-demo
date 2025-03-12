variable "location" {
  default     = "eastus"
  description = "Location where resources will be created"
  type        = string
}

variable "prefix" {
  default     = "tfproduction"
  description = "Prefix for resource naming"
  type        = string
}

variable "terraform_files_storage_account_name" {
  description = "Storage account name that hosts Terraform files"
  type        = string
}

variable "terraform_files_storage_container_name" {
  description = "Storage container name that hosts Terraform files"
  type        = string
}