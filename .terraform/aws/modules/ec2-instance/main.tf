data "aws_ami" "ubuntu_ami" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

resource "tls_private_key" "ec2_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ec2_key_pair" {
  key_name   = "deployer-key"
  public_key = tls_private_key.ec2_private_key.public_key_openssh
}

resource "aws_instance" "aws_test_instance" {
  ami           = data.aws_ami.ubuntu_ami.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.ec2_key_pair.key_name

  security_groups = ["default", "ssh-security-group"]

  tags = {
    name = "aws-test-instance"
  }
}

# Create EC2 Instances inventory file for Ansible
resource "aws_s3_object" "ec2_inventory_file" {
  bucket = var.terraform_files_bucket_id
  key    = "ec2-inventory.json"

  content = jsonencode({
    ec2_instances = aws_instance.aws_test_instance.*.public_ip
  })
}

# Create SSH key file for Ansible
resource "aws_s3_object" "ec2_key_file" {
  bucket = var.terraform_files_bucket_id
  key    = "ec2_key.pem"

  content = tls_private_key.ec2_private_key.private_key_pem
}