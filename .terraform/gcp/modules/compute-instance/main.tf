data "google_compute_zones" "compute_zones" {
}

resource "tls_private_key" "compute_instance_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "google_compute_instance" "production" {
  machine_type = "n1-standard-1"
  name         = "tfproduction-linux-vm"
  zone         = data.google_compute_zones.compute_zones.names[0]

  boot_disk {
    initialize_params {
      image = "ubuntu-minimal-2210-kinetic-amd64-v20230126"
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${tls_private_key.compute_instance_private_key.public_key_openssh}"
  }

  network_interface {
    network = "default"
    access_config {}
  }
}

# Create Cloud Compute VM Instances inventory file for Ansible
resource "google_storage_bucket_object" "compute_instance_inventory_file" {
  bucket = var.terraform_files_bucket_id
  name   = "compute-instance-inventory.json"

  content = jsonencode({
    compute_instances = google_compute_instance.production.network_interface[0].access_config[0].nat_ip
  })
}

# Create SSH key file for Ansible
resource "google_storage_bucket_object" "ec2_key_file" {
  bucket = var.terraform_files_bucket_id
  name   = "civm_key.pem"

  content = tls_private_key.compute_instance_private_key.private_key_pem
}