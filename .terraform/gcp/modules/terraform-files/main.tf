resource "google_storage_bucket" "terraform_files" {
  force_destroy = true
  location      = var.location
  name          = "actions-bucket-terraform-files"

  lifecycle_rule {
    action {
      type = "Delete"
    }

    condition {
      age = 30
    }
  }

  versioning {
    enabled = true
  }
}

output "terraform_files_bucket_id" {
  value = google_storage_bucket.terraform_files.id
}