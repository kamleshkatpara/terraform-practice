terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.9.0"
    }
  }
}


variable "instance_type" {
  type        = string
  description = "The size of the instance."
  #sensitive = true
  validation {
    condition     = can(regex("^t2.", var.instance_type))
    error_message = "The instance must be a t2 type EC2 instance."
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

locals {
  ami           = "ami-072ec8f4ea4a6f2cf"
  instance_type = var.instance_type
}

resource "aws_instance" "my_server" {
  ami           = local.ami
  instance_type = local.instance_type
}

output "public_ip" {
  value = aws_instance.my_server.public_ip
}
