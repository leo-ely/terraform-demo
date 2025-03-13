module "google_compute_instance" {
  source                    = "./modules/compute-instance"
  terraform_files_bucket_id = local.terraform_files_bucket_id
}