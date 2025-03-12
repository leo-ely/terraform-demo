data "aws_ami" "amazon_linux" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "aws_test_instance" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"

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