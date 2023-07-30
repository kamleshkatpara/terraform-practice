terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.9.0"
    }
  }
}


provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "my_app_server" {
  for_each = {
    nano  = "t2.nano"
    micro = "t2.micro"
    small = "t2.small"
  }
  ami           = "ami-072ec8f4ea4a6f2cf"
  instance_type = each.value
  tags = {
    Name = "Server-${each.key}"
  }
}

output "public_ip" {
  value = values(aws_instance.my_app_server)[*].public_ip
}
