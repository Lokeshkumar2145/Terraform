variable "instance_name" {
  description = "Name of the frontend EC2 instance"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the frontend EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the frontend EC2 instance"
  type        = string
}

variable "key_name" {
  description = "Key pair name for the frontend EC2 instance"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the frontend EC2 instance"
  type        = string

}

variable "security_groups" {
  description = "Security groups for the frontend EC2 instance"
  type        = list(string)
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
