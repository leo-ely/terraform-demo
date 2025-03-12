output "terraform_files_bucket_id" {
  value = data.aws_s3_bucket.tf_bucket.id == "" ? aws_s3_bucket.tf_files[0].id : data.aws_s3_bucket.tf_bucket.bucket
}