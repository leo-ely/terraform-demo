variable "project-id" {
  type        = string
  description = "GCP Project ID"
}

variable "region" {
  type        = string
  description = "GCP Bucket Region"
  default     = "us-east1"
}

variable "tf-state-bucket-id" {
  type        = string
  description = "GCP Bucket for Terraform state"
}