module "gcp-bucket" {
  source     = "./modules/gcs-bucket"
  location   = var.location
  project_id = var.project_id
}