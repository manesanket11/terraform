terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      AWS_ACCESS_KEY_ID = AKIA6KJBJD7UPEIACF63
      AWS_SECRET_ACCESS_KEY = 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
      AWS_REGION = us-east-1

      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "web_app" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = merge(var.common_tags, { Name = var.instance_name })
}

