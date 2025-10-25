variable "aws_region" {
  description = "AWS region where resources are created."
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "Optional override for the AMI ID used to launch the EC2 instance."
  type        = string
  default     = null
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "Value assigned to the Name tag."
  type        = string
  default     = "HelloWorld"
}

variable "common_tags" {
  description = "Additional tags to apply to the instance."
  type        = map(string)
  default     = {}
}
