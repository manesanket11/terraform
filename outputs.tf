output "instance_id" {
  description = "Identifier of the EC2 instance."
  value       = aws_instance.web_app.id
}

output "public_ip" {
  description = "Public IP assigned to the EC2 instance."
  value       = aws_instance.web_app.public_ip
}
