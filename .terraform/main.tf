terraform {
  backend "gcs" {
    bucket = "terraform-gcp-demo"
    prefix = "prod"
  }
}

provider "google" {
  project = var.project
  region  = var.region
}