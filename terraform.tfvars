# vpc_name            = "vpc_test"
# tenancy             = "default"
# cidr_block_vpc      = "10.0.0.0/27"

# availability_zone_1 = "ap-southeast-1a"
# availability_zone_2 = "ap-southeast-1b"
# availability_zone_3 = "ap-southeast-1c"

# cidr_block_public1  = "10.0.0.0/24"
# subnet_name_public1 = "publicT1"

# cidr_block_public2  = "10.0.1.0/24"
# subnet_name_public2 = "publicT2"

# cidr_block_private1 = "10.0.2.0/24"
# subnet_name_private1 = "privateT3"

# cidr_block_private2 = "10.0.3.0/24"
# subnet_name_private2 = "privateT4"

# igw_name              = "internet"

# # Route Tables (public and private)
# public_route_table_cidrblock = "0.0.0.0/0"
# public_route_table_Name     = "publicrt"
# private_route_table_Name    = "privatert"
# private_route_table_cidrblock = "0.0.0.0/0"

# eip_name             = "eipT"
# ngw_name             = "ngwT"

# # Frontend Instance Variables
# frontend_instance_name = "frontend_instance"
# ami_id_f              = "ami-06cf27caccffc699c"
# instance_type_f       = "t2.micro"
# key_name_f            = "tf_key"

# # Frontend Security Groups -----------------------------

# # Ingress Variables
# protocol_tcp        = "tcp"
# frontend_http_port  = 80
# frontend_ssh_port   = 22
# frontend_custom_port = 8000

# frontend_ingress_cidr = ["0.0.0.0/0"]
# frontend_egress_cidr  = ["0.0.0.0/0"]

# # Security Group Tags
# frontend_sg_name     = "frontend-sg-T"

# # SSH Configuration for Frontend
# ssh_user             = "ubuntu"
# ssh_private_key_path = "C:/Users/LENOVO/Desktop/TFmodules/tf_key.pem"
# ssh_port             = 22
# ssh_timeout          = "4m"

# # Instance variables for Backend
# backend_instance_name = "backend-ec2"
# ami_id_b              = "ami-05d8605a8c4737417"
# instance_type_b       = "t2.micro"
# key_name_b            = "fundoo-backend-key"

# # Backend Security Groups
# ingress_cidr          = "0.0.0.0/0"
# backend_security_group_name = "backend-sg-T"
# ssh_port_backend      = 22
# backend_port          = 8000
# database_port         = 5432

# # SSH connection for Backend
# private_key_path_backend = "C:/Users/egoud/Downloads/fundoo-backend-key.pem"
# private_key_path_frontend = "C:/Users/egoud/Downloads/fundoo-frontend-key.pem"
# timeout                 = "4m"

# # Database Security Groups
# database_security_group_name = "database-sg-T"

# # Database EC2 Variables
# ami_id_database             = "ami-0dee22c13ea7a9a67"
# instance_type_database      = "t3.micro"
# key_name_database           = "fundoo-database-key"
# database_name_tag           = "database-instance"

# # Database PostgreSQL Setup Command
# database_postgresql_update_command = [
#   "echo 'Running setup for Database EC2'",
#   "sudo apt update -y",
#   "sudo apt install -y postgresql postgresql-contrib",
#   "sudo systemctl enable postgresql",
#   "sudo systemctl start postgresql",
#   "sudo -u postgres psql -c \"CREATE USER eran WITH PASSWORD '123456789';\"",
#   "sudo -u postgres psql -c \"CREATE DATABASE fundoodb OWNER eran;\"",
#   "sudo sed -i \"s/#listen_addresses = 'localhost'/listen_addresses = '*'/g\" /etc/postgresql/16/main/postgresql.conf",
#   "sudo bash -c 'echo \"host all all 0.0.0.0/0 md5\" >> /etc/postgresql/*/main/pg_hba.conf'",
#   "sudo systemctl restart postgresql"
# ]

# # Database Connection Variables
# bastion_user               = "ubuntu"
# bastion_private_key_path   = "C:/Users/egoud/Downloads/fundoo-frontend-key.pem"
# private_key_path_database  = "C:/Users/egoud/Downloads/fundoo-database-key.pem"

# # Backend Target Groups
# lb_tg_backend_name        = "tf-back-lb-tg"
# backend_target_group_port = 8000
# backend_target_group_protocol = "HTTP"

# # Health Checks
# health_check_path               = "/home/"
# health_check_interval           = 30
# health_check_timeout            = 5
# health_check_healthy_threshold  = 3
# health_check_unhealthy_threshold = 2

# # Backend Load Balancer
# backend_lb_name  = "Lb-backend"
# internal_lb      = true
# load_balancer_type = "application"
# target_group_port = 80

# # Frontend Target Group
# lb_tg_frontend_name = "tf-front-lb-tg"

# # Frontend Load Balancer
# frontend_lb_name    = "Lb-Frontend"
# frontend_lb_internal = false
# frontend_lb_type    = "application"

# # Backend EC2 Launch Template and Auto Scaling Group
# backend_ami_name = "Backami-T"
# backend_LT_name  = "backend-T"
# backend_IT_LT    = "t3.micro"

# # Auto Scaling Group Variables
# backend_asg_name    = "backend-asg"
# desired_capacity     = 2
# max_size             = 5
# min_size             = 1
# latest_version       = "$Latest"
# backend_ags_tag_name = "back-asg-T"
# health_check_type    = "ELB"
# health_check_grace_period = 300
# backend_asg_policy_name = "backend-target-tracking-policy"
# backend_asg_policy_type = "TargetTrackingScaling"
# asg_metric_type      = "ASGAverageCPUUtilization"
# asg_metric_value     = 70
# listener_type        = "forward"