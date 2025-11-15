# Create Security Group - SSH Traffic and other ports
resource "aws_security_group" "web-traffic" {
  name = "My_Security_Group2"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "My_SG2"
  }
}

# Security Group for web traffic (HTTP/HTTPS)
resource "aws_security_group" "vpc-web" {
  name        = "vpc-web"
  description = "Allow web traffic"
  vpc_id      = data.aws_vpc.selected.id # <-- replace with your actual VPC resource or ID

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group for SSH access
resource "aws_security_group" "vpc-ssh" {
  name        = "vpc-ssh"
  description = "Allow SSH access"
  vpc_id      = data.aws_vpc.selected.id # <-- replace with your actual VPC resource or ID

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

