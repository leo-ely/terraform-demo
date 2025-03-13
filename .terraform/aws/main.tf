module "amazon_ec2_instance" {
  source                    = "./modules/ec2-instance"
  terraform_files_bucket_id = local.terraform_files_bucket_id
}