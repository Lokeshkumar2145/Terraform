variable "vpc_name"{
    default = "Lab_vpc"
  
}

variable "cidr_block_vpc" {
    default = "10.0.0.0/16"
  
}
# Az's
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
    default = "publicT1"
  
}

variable "cidr_block_public2" {
  default = "10.0.1.0/24"
}

variable "subnet_name_public2" {
  default = "publicT2"
}

variable "cidr_block_private1" {
  default = "10.0.2.0/24"
}

variable "subnet_name_private1" {
  default = "privateT3"
}

variable "cidr_block_private2" {
  default = "10.0.3.0/24"
}
variable "subnet_name_private2" {
  default = "privateT4"
}
variable "igw_name" {
    default = "IgwT"
  
}

variable "eip_name" {
  default = "eipT"
}
variable "ngw_name" {
  default = "ngwT"
}
variable "private_rt_name" {
  default = "private-rt"
}
variable "public_rt_name" {
  default = "public-rt"
}

#security Groups variable frontend
variable "SG_frontend_name" {
  default = "Frontend-SG"
}

#instance variable frontend

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
#security Groups variable backend
variable "SG_backend_name" {
  default = "Backend-SG"
}

#instance variable backend

variable "backend_instance_name" {
  default = "backend-ec2"
}

variable "ami_id_b" {
  default = "ami-04489cd213d4ff7d6"
}

variable "instance_type_b" {
  default = "t2.micro"
}
variable "key_name_b" {
  default = "tf_key"
}