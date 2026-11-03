terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
 
provider "aws" {
  region = "us-east-1"
}
 
# Find the latest Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
 
  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
 
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
 
# Simple test EC2 instance
resource "aws_instance" "terraform_test" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"
 
  tags = {
    Name      = "terraform-test"
    ManagedBy = "Terraform"
  }
}
 
output "ami_id" {
  value = data.aws_ami.amazon_linux.id
}
 
output "instance_id" {
  value = aws_instance.terraform_test.id
}
 
output "private_ip" {
  value = aws_instance.terraform_test.private_ip
}
 
has context menu
