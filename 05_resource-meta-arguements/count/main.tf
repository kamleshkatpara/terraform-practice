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
  count         = 2
  ami           = "ami-072ec8f4ea4a6f2cf"
  instance_type = "t2.micro"
  tags          = { Name = "Server-${count.index}" }
}

output "public_ip" {
  value = aws_instance.my_app_server[*].public_ip
}
