output "instance_ip_addr" {
  value = aws_instance.my_app_server.public_ip
}
