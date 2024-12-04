resource "aws_route_table" "private_rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.private_route_table_cidrblock
    gateway_id = var.nat_gateway_id
  }

  tags = {
    Name = var.private_rt_name
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.public_route_table_cidrblock
    gateway_id = var.internet_gateway_id
  }

  tags = {
    Name = var.public_rt_name
  }
}

# Route Table Associations for Public Subnets
resource "aws_route_table_association" "public1_associations" {
  subnet_id      = var.public_subnet1_id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public2_associations" {
  subnet_id      = var.public_subnet2_id
  route_table_id = aws_route_table.public_rt.id
}

# Route Table Associations for Private Subnets
resource "aws_route_table_association" "private1_associations" {
  subnet_id      = var.private_subnet1_id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private2_associations" {
  subnet_id      = var.private_subnet2_id
  route_table_id = aws_route_table.private_rt.id
}
