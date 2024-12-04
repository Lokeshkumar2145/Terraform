output "vpc_id" {
  value = module.vpc.vpc_id
}
output "public_subnet_1_id" {
  value = module.subnets.public_subnet_1_id
}
output "public_subnet_2_id" {
  value = module.subnets.public_subnet_2_id
}

output "private_subnet_1_id" {
  value = module.subnets.private_subnet_1_id
}
output "private_subnet_2_id" {
  value = module.subnets.private_subnet_2_id
}
output "internet_gateway_id" {
  value = module.internet_gateway.internet_gateway_id
}
output "nat_gateway_id" {

  value       = module.nat_gateway.nat_gateway_id
}

output "eip_id" {
  value       = module.nat_gateway.eip_id
}

output "private_route_table_id" {
  value       = module.route_tables.private_rt_id
}

output "public_route_table_id" {
  value       = module.route_tables.public_rt_id
}

output "frontend_sg_id" {
  value = module.frontend_sg.security_group_id
}

output "backend_sg_id" {
  value = module.backend_sg.security_group_id
}

output "database_sg_id" {
  value = module.database_sg.security_group_id
}

#------------------------------------------
# output "frontend_instance_public_ip" {

#   value       = module.frontend_instance.frontend_instance_public_ip
# }

# output "frontend_instance_private_ip" {

#   value       = module.frontend_instance.frontend_instance_private_ip
# }

# output "frontend_instance_id" {
#   value       = module.frontend_instance.frontend_instance_id
# }
