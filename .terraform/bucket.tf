resource "google_storage_bucket" "gcs_bucket" {
  project                     = var.project-id
  location                    = var.region
  name                        = "terraform-bucket-gcp-demo"
  force_destroy               = false
  uniform_bucket_level_access = true
}