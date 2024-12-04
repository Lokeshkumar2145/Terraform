# output "frontend_instance_id" {
#   value = aws_instance.backend.id
# }
# output "frontend_instance_type" {
#   value = aws_instance.backend.instance_type
# }
# output "frontend_instance_key_name" {
#   value = aws_instance.backend.key_name
# }
# output "frontend_instance_public_ip" {
#   value = aws_instance.backend.public_ip
# }

output "instance_id" {
  value       = module.frontend_instance.frontend_instance_id
}

output "instance_type" {
  value       = module.frontend_instance.frontend_instance_type
}

output "instance_key_name" {
  value       = module.frontend_instance.frontend_instance_key_name
}

output "instance_public_ip" {
  value       = module.frontend_instance.frontend_instance_public_ip
}
