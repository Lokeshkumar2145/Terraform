variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "private_rt_name" {
  description = "Name of the private route table"
  type        = string
}

variable "public_rt_name" {
  description = "Name of the public route table"
  type        = string
}

variable "private_route_table_cidrblock" {
  description = "CIDR block for the private route table"
  type        = string
}

variable "public_route_table_cidrblock" {
  description = "CIDR block for the public route table"
  type        = string
}

variable "nat_gateway_id" {
  description = "ID of the NAT Gateway"
  type        = string
}

variable "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  type        = string
}

variable "public_subnet1_id" {
  description = "ID of the first public subnet"
  type        = string
}

variable "public_subnet2_id" {
  description = "ID of the second public subnet"
  type        = string
}

variable "private_subnet1_id" {
  description = "ID of the first private subnet"
  type        = string
}

variable "private_subnet2_id" {
  description = "ID of the second private subnet"
  type        = string
}
