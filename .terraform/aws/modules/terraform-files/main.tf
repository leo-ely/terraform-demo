data "aws_s3_bucket" "tf_bucket" {
  bucket = "aws-actions-terraform-files"
}

resource "aws_s3_bucket" "tf_files" {
  count  = data.aws_s3_bucket.tf_bucket.id == "" ? 1 : 0
  bucket = "aws-actions-terraform-files"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "tf_files_versioning" {
  count  = data.aws_s3_bucket.tf_bucket.id == "" ? 1 : 0
  bucket = aws_s3_bucket.tf_files[0].id

  versioning_configuration {
    status = "Enabled"
  }
}