resource "aws_instance" "aws-test-instance" {
  ami           = "ami-04e914639d0cca79a"
  instance_type = "t2.micro"
  tags = {
    name = "aws-test-instance"
  }
}