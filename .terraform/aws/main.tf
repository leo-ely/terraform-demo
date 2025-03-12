# Sources for hosting Terraform's state file
module "terraform_files" {
  source = "./modules/terraform-files"
}

module "amazon_ec2_instance" {
  depends_on = [module.terraform_files.terraform_files_bucket_id]
  source                    = "./modules/ec2-instance"
  terraform_files_bucket_id = module.terraform_files.terraform_files_bucket_id
}