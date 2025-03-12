data "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "aws-actions-terraform-files"
}

resource "aws_s3_bucket" "terraform_files" {
  count  = data.aws_s3_bucket.terraform_state_bucket.id == "" ? 1 : 0
  bucket = "aws-actions-terraform-files"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_files[0].id

  versioning_configuration {
    status = "Enabled"
  }
}