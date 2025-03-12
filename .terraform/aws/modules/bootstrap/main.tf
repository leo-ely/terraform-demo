provider "aws" {
  region = var.region
}

module "backend" {
  source = "../terraform-files/"
}