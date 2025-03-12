variable "location" {
  default     = "us-east1"
  description = "Location where resources will be created"
  type        = string
}

variable "terraform_files_bucket_id" {
  description = "Bucket ID that hosts Terraform files"
  type        = string
}