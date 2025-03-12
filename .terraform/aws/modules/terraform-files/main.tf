resource "aws_s3_bucket" "terraform_files" {
  bucket = "terraform-files"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_files.id

  versioning_configuration {
    status = "Enabled"
  }
}

output "terraform_files_bucket_id" {
  value = aws_s3_bucket.terraform_files.id
}