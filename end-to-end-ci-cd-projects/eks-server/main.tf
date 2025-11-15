resource "aws_instance" "EKS-Server" {
  ami                    = data.aws_ami.amazonlinux2.id
  instance_type          = var.my_instance_type
  key_name               = var.my_key
  vpc_security_group_ids = [aws_security_group.web-traffic.id]

  tags = {
    "Name" = "EKS-Server"
  }
}
