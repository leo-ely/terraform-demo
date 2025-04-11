terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  required_version = "~>1.11.0"

  backend "s3" {}
}