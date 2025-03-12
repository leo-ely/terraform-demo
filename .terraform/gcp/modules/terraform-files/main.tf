data "google_storage_bucket" "terraform_bucket" {
  name = "actions-bucket-terraform-files"
}

resource "google_storage_bucket" "terraform_files" {
  count         = try(data.google_storage_bucket.terraform_bucket.id, null) == null ? 1 : 0
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