output "public_ip" {
  description = "Public IP of the frontend EC2 instance"
  value       = aws_instance.frontend_instance.public_ip
}

output "private_ip" {
  description = "Private IP of the frontend EC2 instance"
  value       = aws_instance.frontend_instance.private_ip
}

output "instance_id" {
  description = "ID of the frontend EC2 instance"
  value       = aws_instance.frontend_instance.id
}
