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

resource "aws_s3_bucket" "bucket" {
  bucket = "wesohaex-depends-on"
}

resource "aws_instance" "my_server" {
  ami           = "ami-072ec8f4ea4a6f2cf"
  instance_type = "t2.micro"
  depends_on = [
    aws_s3_bucket.bucket
  ]
}

output "public_ip" {
  value = aws_instance.my_server.public_ip
}
