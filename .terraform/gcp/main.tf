# Sources for hosting Terraform's state file
module "terraform-files" {
  source   = "./modules/terraform-files"
  location = var.location
}

module "google-compute-instance" {
  source                    = "./modules/compute-instance"
  location                  = var.location
  terraform_files_bucket_id = module.terraform-files.terraform_files_bucket_id
}