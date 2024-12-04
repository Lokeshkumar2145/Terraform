# Outputs

output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_1_id" {
  value = aws_subnet.public1.id
}
output "public_subnet_2_id" {
  value = aws_subnet.public2.id
}

output "private_subnet_1_id" {
  value = aws_subnet.private1.id
}
output "private_subnet_2_id" {
  value = aws_subnet.private2.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.internet_connection.id
}
output "nat_gateway_id" {
  value = aws_nat_gateway.NAT
}
output "private_rt_id" {
  value = aws_route_table.private_rt.id
}

output "public_rt_id" {
  value = aws_route_table.public_rt.id
}
output "eip_id" {
  value = aws_eip.eip
}
output "frontend_lb_dns" {
  value = aws_lb.frontend_lb.dns_name
}