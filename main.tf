terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "allow_all" {
  name        = "${var.instance_name}-allow-all"
  description = "Allow all inbound and outbound traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description      = "Allow all inbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(var.common_tags, { Name = "${var.instance_name}-sg" })
}

resource "aws_instance" "web_app" {
  ami                    = coalesce(var.ami_id, data.aws_ami.amazon_linux_2.id)
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_all.id]
  iam_instance_profile   = aws_iam_instance_profile.ssm.name

  tags = merge(var.common_tags, { Name = var.instance_name })

  user_data = <<-EOF
              #!/bin/bash
              set -xe
              yum update -y
              yum install -y httpd
              systemctl enable httpd
              cat > /var/www/html/index.html <<'HTML'
              <!DOCTYPE html>
              <html lang="en">
              <head>
                <meta charset="UTF-8">
                <meta http-equiv="X-UA-Compatible" content="IE=edge">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Hello from Codex</title>
              </head>
              <body>
                <h1>Hello World</h1>
                <p>This is using Codex.</p>
              </body>
              </html>
              HTML
              systemctl start httpd
              EOF
}
