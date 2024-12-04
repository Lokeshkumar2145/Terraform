resource "aws_subnet" "public1" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_block_public1
  availability_zone = var.availability_zone_1

  tags = {
    Name = var.subnet_name_public1
  }
}
resource "aws_subnet" "public2" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_block_public2
  availability_zone = var.availability_zone_2

  tags = {
    Name = var.subnet_name_public2
  }
}


resource "aws_subnet" "private1" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_block_private1
  availability_zone = var.availability_zone_1

  tags = {
    Name = var.subnet_name_private1
  }
}

resource "aws_subnet" "private2" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_block_private2
  availability_zone = var.availability_zone_2

  tags = {
    Name = var.subnet_name_private1
  }
}