resource "aws_s3_bucket" "terraform_files" {
  bucket = "aws-actions-terraform-files"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "terraform_files_versioning" {
  bucket = aws_s3_bucket.terraform_files[0].id

  versioning_configuration {
    status = "Enabled"
  }
}