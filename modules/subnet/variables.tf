variable "vpc_id" {
  
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
