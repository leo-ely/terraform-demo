variable "project-id" {
  type        = string
  description = "GCP Project ID"
}

variable "region" {
  type        = string
  description = "GCP Bucket Region"
  default     = "us-east1"
}