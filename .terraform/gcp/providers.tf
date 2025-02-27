provider "google" {
  project = var.project_id
  region  = var.location
}

terraform {
  backend "gcs" {}
}