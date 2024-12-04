
variable "vpc_id" {
  description = "The ID of the VPC to associate with the Internet Gateway"
  type        = string
}

variable "igw_name" {
  description = "Name of the Internet Gateway"
  type        = string
}

variable "tags" {
  description = "Additional tags to add to the Internet Gateway"
  type        = map(string)
  default     = {}
}
