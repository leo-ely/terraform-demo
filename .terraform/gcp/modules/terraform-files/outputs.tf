output "terraform_files_bucket_id" {
  value = data.google_storage_bucket.tf_bucket.id == "" ? google_storage_bucket.tf_files[0].id : data.google_storage_bucket.tf_bucket.id
}