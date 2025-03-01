variable "project_id" {
  description = "Google Cloud Platform Project ID"
  type        = string
}

variable "location" {
  default     = "us-east1"
  description = "Location where resources will be created"
  type        = string
}