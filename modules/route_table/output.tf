output "private_rt_id" {
  description = "The ID of the private route table"
  value       = aws_route_table.private_rt.id
}

output "public_rt_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.public_rt.id
}
