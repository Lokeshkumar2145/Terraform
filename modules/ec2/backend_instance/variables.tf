variable "backend_instance_name" {
  description = "Name of the backend EC2 instance"
  type        = string
}

variable "ami_id_b" {
  description = "AMI ID for backend EC2 instance"
  type        = string
}

variable "instance_type_b" {
  description = "Instance type for backend EC2 instance"
  type        = string
}

variable "key_name_b" {
  description = "Key pair name for backend EC2 instance"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the backend EC2 instance"
  type        = string
}

variable "security_groups" {
  description = "Security group for backend EC2 instance"
  type        = list(string)
}

variable "database_private_ip" {
  description = "Private IP of the database instance"
  type        = string
}

variable "key_path" {
  description = "Path to the private key"
  type        = string
}

variable "bastion_host" {
  description = "Bastion host public IP"
  type        = string
}
