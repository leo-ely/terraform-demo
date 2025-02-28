variable "location" {
  default     = "eastus"
  description = "Location where resources will be created"
  type        = string
}

variable "tf_state_resource_group_name" {
  default     = "tfstate"
  description = "Resource group name for Terraform state"
  type        = string
}