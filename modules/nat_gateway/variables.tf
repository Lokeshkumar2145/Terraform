variable "ngw_name" {
  description = "The name of the NAT Gateway."
  type        = string
}

variable "eip_name" {
  description = "The name for the Elastic IP."
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID where the NAT Gateway will be deployed."
  type        = string
}

variable "internet_id" {
  description = "The subnet ID where the NAT Gateway will be deployed."
  type        = string
}