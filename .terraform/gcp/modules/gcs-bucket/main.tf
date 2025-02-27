resource "google_storage_bucket" "gcs_bucket" {
  force_destroy               = false
  location                    = var.location
  name                        = "terraform-bucket-gcp-demo"
  project                     = var.project_id
  uniform_bucket_level_access = true
}