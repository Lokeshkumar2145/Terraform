variable "vpc_name"{}
variable "cidr_block_vpc" {}
# Az's
variable "availability_zone_1" {}
variable "availability_zone_2" {}
variable "cidr_block_public1"{}
variable "subnet_name_public1" {}
variable "cidr_block_public2" {}
variable "subnet_name_public2" {}
variable "cidr_block_private1" {}
variable "subnet_name_private1" {}
variable "cidr_block_private2" {}
variable "subnet_name_private2" {}
variable "igw_name" {}
variable "eip_name" {}
variable "ngw_name" {}
variable "private_rt_name" {}
variable "public_rt_name" {}
#security Groups variable frontend
variable "SG_frontend_name" {}
#instance variable frontend
variable "frontend_instance_name" {}
variable "ami_id_f" {}
variable "instance_type_f" {}
variable "key_name_f" {}
#security Groups variable backend
variable "SG_backend_name" {}
#instance variable backend
variable "backend_instance_name" {}
variable "ami_id_b" {}
variable "instance_type_b" {}
variable "key_name_b" {}
variable "key_path" {default = "./tf_keys/tf_dev_key.pem"}
# variable "key_path_content" {}
# variable "key_path_state" {}

# Backend Target Groups
variable "lb_tg_backend_name" {}
# variable "backend_target_group_port" {}
variable "backend_target_group_protocol" {}
# Health Checks
variable "health_check_path" {}
variable "health_check_interval" {}
variable "health_check_timeout" {}
variable "health_check_healthy_threshold" {}
variable "health_check_unhealthy_threshold" {}
# Backend Load Balancer
variable "backend_lb_name" {}
variable "load_balancer_type" {}
variable "target_group_port" {}
# Frontend Target Group
variable "lb_tg_frontend_name" {}
# Frontend Load Balancer
variable "frontend_lb_name" {}
variable "frontend_lb_type" {}
variable "listener_type" {}