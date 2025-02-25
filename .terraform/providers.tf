provider "google" {
  project = var.project-id
  region  = var.region
}

terraform {
  backend "gcs" {}
}