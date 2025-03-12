output "terraform_files_bucket_id" {
  value = try(
    data.google_storage_bucket.terraform_bucket.id,
    google_storage_bucket.terraform_files[0].id
  )
}