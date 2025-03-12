output "terraform_files_bucket_id" {
  value = data.aws_s3_bucket.terraform_state_bucket.id == ""
    ? aws_s3_bucket.terraform_files[0].id : data.aws_s3_bucket.terraform_state_bucket.bucket
}