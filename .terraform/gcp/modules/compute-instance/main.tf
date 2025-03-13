resource "google_compute_instance" "production" {
  machine_type = "n1-standard-1"
  name         = "tfproduction-linux-vm"

  boot_disk {
    initialize_params {
      image = "ubuntu-minimal-2210-kinetic-amd64-v20230126"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }
}

resource "google_storage_bucket_object" "compute_instance_inventory_file" {
  bucket = var.terraform_files_bucket_id
  name   = "compute-instance-inventory.json"

  content = jsonencode({
    compute_instances = google_compute_instance.production.network_interface[0].access_config[0].nat_ip
  })
}