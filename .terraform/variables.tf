locals {
  labels = {
    "data-project" = var.data-project
  }
}

variable "project" {
  type        = string
  description = "GCP Project ID"
}

variable "region" {
  type    = string
  default = "GCP Bucket Region"
}

variable "data-project" {
  type        = string
  description = "Data pipeline project name (to use as resource prefix)"
}