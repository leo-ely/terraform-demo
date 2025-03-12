# Sources for hosting Terraform's state file
module "terraform_files" {
  source   = "./modules/terraform-files"
  location = var.location
}

module "google_compute_instance" {
  source                    = "./modules/compute-instance"
  location                  = var.location
  terraform_files_bucket_id = module.terraform_files.terraform_files_bucket_id
}