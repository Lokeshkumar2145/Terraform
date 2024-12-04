module "vpc" {
  source           = "./modules/vpc"
  vpc_name         = var.vpc_name
  cidr_block_vpc   = var.cidr_block_vpc
  tenancy          = var.tenancy1

}

module "subnets" {
    source              = "./modules/subnet"
    vpc_id              = module.vpc.vpc_id
    cidr_block_public1  = var.cidr_block_public1
    subnet_name_public1 = var.subnet_name_public1
    cidr_block_public2  = var.cidr_block_public2
    subnet_name_public2 = var.subnet_name_public2
    cidr_block_private1 = var.cidr_block_private1
    subnet_name_private1 = var.subnet_name_private1
    cidr_block_private2 = var.cidr_block_private2
    subnet_name_private2 = var.subnet_name_private2
    availability_zone_1 = var.availability_zone_1
    availability_zone_2 = var.availability_zone_2
}

module "internet_gateway" {
  source   = "./modules/internet_gateway"
  vpc_id   = module.vpc.vpc_id
  igw_name = var.internet
}

module "nat_gateway" {
  source    = "./modules/nat_gateway"
  ngw_name  = var.ngw_name1
  eip_name  = var.eip_name1
  subnet_id = module.subnets.public_subnet_1_id
  internet_id = module.internet_gateway.internet_gateway_id
}

module "route_tables" {
  source                       = "./modules/route_table"
  vpc_id                       = module.vpc.vpc_id
  private_rt_name              = var.private_rt_name
  public_rt_name               = var.public_rt_name
  private_route_table_cidrblock = var.private_route_table_cidrblock
  public_route_table_cidrblock = var.public_route_table_cidrblock
  nat_gateway_id               = module.nat_gateway.nat_gateway_id
  internet_gateway_id          = module.internet_gateway.internet_gateway_id
  public_subnet1_id            = module.subnets.public_subnet_1_id
  public_subnet2_id            = module.subnets.public_subnet_2_id
  private_subnet1_id           = module.subnets.private_subnet_1_id
  private_subnet2_id           = module.subnets.private_subnet_2_id
}


module "frontend_sg" {
  source       = "./modules/security_group"
  vpc_id       = module.vpc.vpc_id
  name         = var.SG_frontend_name
  ingress_rules = [
    { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
    { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
    { from_port = 8000, to_port = 8000, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
  ]
  egress_rules = [
    { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] },
  ]
}

module "backend_sg" {
  source       = "./modules/security_group"
  vpc_id       = module.vpc.vpc_id
  name         = var.SG_backend_name
  ingress_rules = [
    { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
    { from_port = 8000, to_port = 8000, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
    { from_port = 5432, to_port = 5432, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
  ]
  egress_rules = [
    { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] },
  ]
}

module "database_sg" {
  source       = "./modules/security_group"
  vpc_id       = module.vpc.vpc_id
  name         = var.SG_Database_name
  ingress_rules = [
    { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
    { from_port = 5432, to_port = 5432, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
  ]
  egress_rules = [
    { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] },
  ]
}



module "frontend_instance" {
  source               = "./modules/ec2/frontend_instance"
  instance_name        = var.frontend_instance_name
  ami_id               = var.ami_id_f
  instance_type        = var.instance_type_f
  key_name             = var.key_name_f
  subnet_id            = module.subnets.public_subnet_1_id
  security_groups      = [module.frontend_sg.security_group_id]
#   frontend_lb_dns      = var.frontend_lb_dns
#   backend_lb_dns       = var.backend_lb_dns
#   key_path             = var.key_path
}

# module "backend_instance" {
#   source               = "./modules/backend_instance"
#   backend_instance_name = "backend-ec2"
#   ami_id_b             = "ami-04489cd213d4ff7d6"
#   instance_type_b      = "t2.micro"
#   key_name_b           = "tf_key"
#   subnet_id            = aws_subnet.private1.id
#   security_groups      = [aws_security_group.backend_sg.id]
#   database_private_ip  = aws_instance.database.private_ip
#   key_path             = "C:/Users/LENOVO/Desktop/terraform/lab2/tf_key.pem"
#   bastion_host         = aws_instance.frontend_instance.public_ip
# }

# module "database_instance" {
#   source               = "./modules/database_instance"
#   database_instance_name = "database-instance"
#   ami_id_d             = "ami-047126e50991d067b"
#   instance_type_d      = "t2.micro"
#   key_name_d           = "tf_key"
#   subnet_id            = aws_subnet.private2.id
#   security_groups      = [aws_security_group.database_sg.id]
#   database_user        = "lokesh"
#   database_password    = "root@123"
#   database_name        = "lokeshdb"
#   key_path             = "C:/Users/LENOVO/Desktop/terraform/lab2/tf_key.pem"
# }


