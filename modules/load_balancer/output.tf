# Frontend Load Balancer Outputs
output "frontend_lb_arn" {
  value = aws_lb.frontend_lb.arn
}

output "frontend_lb_id" {
  value = aws_lb.frontend_lb.id
}

output "frontend_lb_dns_name" {
  value = aws_lb.frontend_lb.dns_name
}
# Backend Load Balancer Outputs
output "backend_lb_arn" {
  value = aws_lb.backend_lb.arn
}

output "backend_lb_id" {
  value = aws_lb.backend_lb.id
}

output "backend_lb_dns_name" {
  value = aws_lb.backend_lb.dns_name
}