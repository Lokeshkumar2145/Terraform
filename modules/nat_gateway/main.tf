resource "aws_eip" "eip" {
  vpc = true

  tags = {
    Name = var.eip_name
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id     = var.subnet_id

  tags = {
    Name = var.ngw_name
  }
}
