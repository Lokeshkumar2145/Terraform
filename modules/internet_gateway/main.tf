resource "aws_internet_gateway" "internet_connection" {
    vpc_id = var.vpc_id
tags = {
    Name = var.igw_name
  }
}
