terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.9.0"
    }
  }
}

variable "instance_type" {
  type = string
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "my_app_server" {
  ami           = "ami-072ec8f4ea4a6f2cf"
  instance_type = var.instance_type
}

output "instance_ip_addr" {
  value = aws_instance.my_app_server.public_ip
}
