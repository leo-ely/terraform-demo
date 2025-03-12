output "terraform_files_bucket_id" {
  value = try(
    data.aws_s3_bucket.terraform_bucket.id,
    aws_s3_bucket.terraform_files[0].id
  )
}