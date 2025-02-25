provider "google" {
  project = var.project-id
  region  = var.region
}

terraform {
  backend "gcs" {
    bucket = var.tf-state-bucket-id
    prefix = "terraform/state"
  }
}