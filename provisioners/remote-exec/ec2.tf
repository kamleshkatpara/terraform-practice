resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCxhUCDYnSTiiHS/iGPZmD1FEnp20bNx2V8vbI/2LGbjattqgNuGJjjyPswRcdfhszwFrkoxUCQQNiAneeRYDVm7x5ObRSZJ9LeEPHsl+2xfoLmDo7qbND9A3chUKg8evMcufPTVNwRITq209Nvagj50MWXUZAZ+zJa+7J5AohCfx0d89AFxIgHyFh1Z8J5HX95sjylgGBxcxffb6iqD9I17row3m4AeoiQqIG4D236Q9AkWU5KvBo7aRrkP+jFTI7nNwo8zvhvnUNbismGtu24PtP13Ev+O2fjM3Ek8Oz6PHCbSYDe+kkvXDbDLHQXYm3jhg80OYrnCzTy84XdWVs9YYXagx6JzGU2xgBiUNSwT+uwTg7kJBv6Ag9d8EfeYi/J/pjWZC+oOdkkvEl5Lo+isETygo8aRBJXZklJbsdYRvF4hkEcb0ateuM8wEaFfYz6rCwm32Krb+Ytv6f/hSBtFRL/oxBbBQSCgo2pNIIDnBQAcVz7LuPd6pa+/SMwbhU= kamlesh@DESKTOP-76D5TSM"
}

resource "aws_instance" "my_app_server" {
  ami                    = "ami-072ec8f4ea4a6f2cf"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.sg_my_server.id]
  user_data              = data.template_file.user_data.rendered
  provisioner "remote-exec" {
    inline = [
      "echo ${self.private_ip} >> /home/ec2-user/private_ips.txt"
    ]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      host        = self.public_ip
      private_key = file("/root/.ssh/terraform")
    }
  }

  tags = {
    Name = "MyAppServerInstance"
  }
}

data "template_file" "user_data" {
  template = file("./userdata.yml")
}
