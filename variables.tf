variable "vpc_name" {
  default = "test_vpc_tf"
}

variable "cidr_block_vpc" {
  default = "10.0.0.0/16"
}

variable "tenancy1" {
    default = "default"
}


variable "availability_zone_1" {
  default = "ap-southeast-1a"
}
variable "availability_zone_2" {
  default = "ap-southeast-1b"
}

variable "cidr_block_public1"{
    default = "10.0.0.0/24"
}
variable "subnet_name_public1" {
    default = "public1"
  
}

variable "cidr_block_public2" {
  default = "10.0.1.0/24"
}

variable "subnet_name_public2" {
  default = "public2"
}

variable "cidr_block_private1" {
  default = "10.0.2.0/24"
}

variable "subnet_name_private1" {
  default = "private3"
}

variable "cidr_block_private2" {
  default = "10.0.3.0/24"
}
variable "subnet_name_private2" {
  default = "private4"
}

variable "internet" {
  default = "Igw"
}


variable "ngw_name1" {
  default     = "NAT-Gateway"
}

variable "eip_name1" {
  default     = "Elastic-IP"
}
#=-------------------------------------------

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
variable "private_rt_name" {
  default = "private-rt"
}

variable "public_rt_name" {
  default = "public-rt"
}

variable "private_route_table_cidrblock" {
  default = "0.0.0.0/0"
}

variable "public_route_table_cidrblock" {
  default = "0.0.0.0/0"
}

#=-------------------------------------------

variable "SG_frontend_name" {
  default = "Frontend-SG"
}

variable "SG_backend_name" {
  default = "Backend-SG"
}

variable "SG_Database_name" {
  default = "Database-SG"
}
#-------------------------------------
variable "frontend_instance_name" {
  default = "frontend-ec2"
}

variable "ami_id_f" {
  default = "ami-06cf27caccffc699c"
}

variable "instance_type_f" {
  default = "t2.micro"

}

variable "key_name_f" {
    default = "tf_key"
}


# variable "frontend_lb_dns" {
#   description = "Frontend Load Balancer DNS name"
#   type        = string
# }

# variable "backend_lb_dns" {
#   description = "Backend Load Balancer DNS name"
#   type        = string
# }

# variable "key_path" {
#   description = "Path to the private key file"
#   type        = string
# }




