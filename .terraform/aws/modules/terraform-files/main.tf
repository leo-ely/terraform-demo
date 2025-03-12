data "aws_s3_bucket" "terraform_bucket" {
  bucket = "aws-actions-terraform-files"
}

resource "aws_s3_bucket" "terraform_files" {
  count  = try(data.aws_s3_bucket.terraform_bucket.id, null) == null ? 1 : 0
  bucket = "aws-actions-terraform-files"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "terraform_files_versioning" {
  count  = try(data.aws_s3_bucket.terraform_bucket.id, null) == null ? 1 : 0
  bucket = aws_s3_bucket.terraform_files[0].id

  versioning_configuration {
    status = "Enabled"
  }
}