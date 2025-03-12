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

variable "terraform_files_resource_group_id" {
  description = "Resource group ID that hosts Terraform files"
  type        = string
}

variable "terraform_files_storage_account_id" {
  description = "Storage account ID that hosts Terraform files"
  type        = string
}

variable "terraform_files_storage_container_id" {
  description = "Storage container ID that hosts Terraform files"
  type        = string
}