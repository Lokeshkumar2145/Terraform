# Creating a VPC

resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block_vpc
  instance_tenancy = "default"

  tags = {
    Name = var.vpc_name
  }
}

#Creating 4 Subnets public2 and Private 2

resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.cidr_block_public1
  availability_zone = var.availability_zone_1

  tags = {
    Name = var.subnet_name_public1
  }
}
resource "aws_subnet" "public2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.cidr_block_public2
  availability_zone = var.availability_zone_2

  tags = {
    Name = var.subnet_name_public2
  }
}


resource "aws_subnet" "private1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.cidr_block_private1
  availability_zone = var.availability_zone_1

  tags = {
    Name = var.subnet_name_private1
  }
}

resource "aws_subnet" "private2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.cidr_block_private2
  availability_zone = var.availability_zone_2

  tags = {
    Name = var.subnet_name_private1
  }
}

#Creating a Internet Gateway
resource "aws_internet_gateway" "internet_connection" {
    vpc_id = aws_vpc.main.id
tags = {
    Name = var.igw_name
  }
}

#Creating a Elastic IP address
resource "aws_eip" "eip" {
  vpc = true

  tags = {
    Name = var.eip_name
  }
}

# Creating a NAT-Gateways
resource "aws_nat_gateway" "NAT" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public1.id

  tags = {
    Name = var.ngw_name
  }

  depends_on = [aws_internet_gateway.internet_connection]
}

#Creating a Private Route Table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.NAT.id
  }

  tags = {
    Name = var.private_rt_name
  }
}
#Creating a Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id   

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_connection.id
  }

  tags = {
    Name = var.public_rt_name
  }
}

#creating Aws_route_table associations
resource "aws_route_table_association" "public1_associations" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public_rt.id
}
resource "aws_route_table_association" "public2_associations" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private1_associations" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private_rt.id
}
resource "aws_route_table_association" "private2_associations" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.private_rt.id
}

#creating Security Group for Frontend Instance
resource "aws_security_group" "frontend_sg" {
  vpc_id = aws_vpc.main.id
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 8000
    to_port = 8000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = var.SG_frontend_name
  }
}
# # Generate a private key locally
# resource "tls_private_key" "terraform1" {
#   algorithm = "RSA"
#   rsa_bits  = 2048
# }

# # Create the EC2 Key Pair with the generated public key
# resource "aws_key_pair" "ec2_key_pair_front" {
#   key_name   = "tf-key"
#   public_key = tls_private_key.terraform1.public_key_openssh
# }

# # Save the private key to a file (optional)
# resource "local_file" "private_key" {
#   content  = tls_private_key.terraform1.private_key_pem
#   filename = "tf_key.pem"
# }

#creating a Frontend Instance
resource "aws_instance" "frontend_instance" {
  ami =  var.ami_id_f
  instance_type = var.instance_type_f
  subnet_id = aws_subnet.public1.id
  key_name = var.key_name_f
  security_groups = [aws_security_group.frontend_sg.id]
  associate_public_ip_address = true 
  tags = {
    Name = var.frontend_instance_name
  }
  provisioner "remote-exec" {
    inline = [
        # Create the file and set the permissions
  "echo '${file("C:/Users/LENOVO/Desktop/terraform/lab2/tf_key.pem")}' > /home/ubuntu/tf_key.pem",
  "chmod 400 /home/ubuntu/tf_key.pem" ,
  # Update server_name with the frontend DNS
  "sudo sed -i 's|server_name .*|server_name ${aws_lb.frontend_lb.dns_name};|' /etc/nginx/sites-available/fundoo.conf",

  # Update proxy_pass with the backend DNS
  "sudo sed -i 's|proxy_pass .*|proxy_pass http://${aws_lb.backend_lb.dns_name}:8000;|' /etc/nginx/sites-available/fundoo.conf",

  # Reload or restart Nginx to apply the changes
  "sudo systemctl daemon-reload",
  "sudo systemctl reload nginx"

]


    connection {
      type                = "ssh"
      user                = "ubuntu"
      private_key         = file("C:/Users/LENOVO/Desktop/terraform/lab2/tf_key.pem")
      host                = self.public_ip
      port                = 22
      timeout             = "4m"
    }
  }
  depends_on = [aws_lb.frontend_lb, aws_lb.backend_lb]

}

#creating a Backend security Groups
resource "aws_security_group" "backend_sg" {
  vpc_id = aws_vpc.main.id
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 8000
    to_port = 8000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = var.SG_backend_name
  }
}

# Creating Database security Groups
resource "aws_security_group" "database_sg" {
  vpc_id = aws_vpc.main.id
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Database_SG"
  }
}

# Create Database EC2 Instance
resource "aws_instance" "database" {
  ami                   = "ami-047126e50991d067b"
  instance_type         = "t2.micro"
  subnet_id             = aws_subnet.private2.id
  key_name              = var.key_name_b
  security_groups       = [aws_security_group.database_sg.id]
  tags = {
    Name = "Database-instance"
  }
}

# Null Resource for Database Setup
resource "null_resource" "database_setup" {
  triggers = {
    instance_id = aws_instance.database.id
  }

  provisioner "remote-exec" {
    inline = [
       # Create the file and set the permissions
      "echo '${file("C:/Users/LENOVO/Desktop/terraform/lab2/tf_key.pem")}' > /home/ubuntu/tf_key.pem",
      "chmod 400 /home/ubuntu/tf_key.pem" ,

      "echo 'Running setup for Database EC2'",
      "sudo apt update -y",
      "sudo apt install -y postgresql postgresql-contrib",
      "sudo systemctl enable postgresql",
      "sudo systemctl start postgresql",
      "sudo -u postgres psql -c \"CREATE USER lokesh WITH PASSWORD 'root@123';\"",
      "sudo -u postgres psql -c \"CREATE DATABASE lokeshdb OWNER lokesh;\"",
      "sudo sed -i \"s/#listen_addresses = 'localhost'/listen_addresses = '*'/g\" /etc/postgresql/16/main/postgresql.conf",
      "sudo bash -c 'echo \"host all all 0.0.0.0/0 md5\" >> /etc/postgresql/*/main/pg_hba.conf'",
      "sudo systemctl restart postgresql"
    ]

    connection {
      type                = "ssh"
      user                = "ubuntu"
      private_key         = file("C:/Users/LENOVO/Desktop/terraform/lab2/tf_key.pem")
      host                = aws_instance.database.private_ip
      port                = 22
      timeout             = "20m"  # Increased timeout for long-running scripts
      bastion_host        = aws_instance.frontend_instance.public_ip
      bastion_user        = "ubuntu"
      bastion_private_key = file("C:/Users/LENOVO/Desktop/terraform/lab2/tf_key.pem")
    }
  }

  depends_on = [aws_instance.database]
}

# Create Backend EC2 Instance
resource "aws_instance" "backend" {
  ami                     = var.ami_id_b
  instance_type           = var.instance_type_b
  key_name                = var.key_name_b
  subnet_id               = aws_subnet.private1.id
  security_groups         = [aws_security_group.backend_sg.id]
  tags = {
    Name = var.backend_instance_name
  }
}

# Null Resource for Backend Setup
resource "null_resource" "backend_setup" {
  triggers = {
    instance_id = aws_instance.backend.id
  }

  provisioner "remote-exec" {
    inline = [
        # Create the file and set the permissions
    "echo '${file("C:/Users/LENOVO/Desktop/terraform/lab2/tf_key.pem")}' > /home/ubuntu/tf_key.pem",
    "chmod 400 /home/ubuntu/tf_key.pem" ,
    "echo 'Updating DB_HOST in env file...'",
    "sudo sed -i 's/DB_HOST=.*/DB_HOST=${aws_instance.database.private_ip}/' /etc/fundoo/env.conf",
    "sudo systemctl daemon-reload",
    "echo 'DB_HOST update completed.'",
    "echo 'Activating virtual environment and running migrations...'",
    "sudo su dev bash -c 'cd /Aws_test && source myenv/bin/activate && echo \"Virtual environment activated.\" && cd /Aws_test/fundoo_notes && python3 manage.py makemigrations && python3 manage.py migrate'",
    "echo 'Migrations completed.'",
    "sudo systemctl restart fundoo.service"
    ]

    connection {
      type                = "ssh"
      user                = "ubuntu"
      private_key        = file("C:/Users/LENOVO/Desktop/terraform/lab2/tf_key.pem")
      host                = aws_instance.backend.private_ip
      bastion_host        = aws_instance.frontend_instance.public_ip
      bastion_private_key = file("C:/Users/LENOVO/Desktop/terraform/lab2/tf_key.pem")
      port                = 22
      timeout             = "10m"
    }
  }

  depends_on = [
    aws_instance.backend,
    null_resource.database_setup  # Ensure database provisioning completes first
  ]
}
#Frontend Target group
resource "aws_lb_target_group" "frontend_tg" {
  name     = "frontend-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = {
    Name = "FrontendTargetGroup"
  }
}

#Frontend Load Balancer

resource "aws_lb" "frontend_lb" {
  name               = "frontend-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.frontend_sg.id]
  subnets            = [aws_subnet.public1.id,aws_subnet.public2.id]

  tags = {
    Name = "FrontendLoadBalancer"
  }
}

#Frontend Listner
resource "aws_lb_listener" "frontend_listener" {
  load_balancer_arn = aws_lb.frontend_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend_tg.arn
  }
}

#Register targets as Frontend instance
resource "aws_lb_target_group_attachment" "frontend_attachment" {
  target_group_arn = aws_lb_target_group.frontend_tg.arn
  target_id        = aws_instance.frontend_instance.id
  port             = 80
}

#Backtend Target group
resource "aws_lb_target_group" "backend_tg" {
  name     = "backend-tg"
  port     = 8000
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = {
    Name = "BackendTargetGroup"
  }
}


#Backend Load balancer
resource "aws_lb" "backend_lb" {
  name               = "backend-load-balancer"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.backend_sg.id]
  subnets            = [aws_subnet.private1.id,aws_subnet.private2.id]


  tags = {
    Name = "Backend-Load-Balancer"
  }
}

#Backend Listener
resource "aws_lb_listener" "backend_listener" {
  load_balancer_arn = aws_lb.backend_lb.arn
  port              = 8000
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_tg.arn
  }
}


#Register target Backend Instance
resource "aws_lb_target_group_attachment" "backend_targets" {
  target_group_arn = aws_lb_target_group.backend_tg.arn
  target_id        = aws_instance.backend.id
  port             = 8000
}

## Autoscalling for backend and frontend

## Autoscalling for backend 
#-----------------------------------------------------#

#backendami-T
resource "aws_ami_from_instance" "backend_ami" {
  name = "Backami-T"
  source_instance_id  = aws_instance.backend.id  

  depends_on = [ null_resource.backend_setup ]
}


#Backend Launch template
resource "aws_launch_template" "back_launch_config" {
  name          = "backend_launch_config"
  image_id      = aws_ami_from_instance.backend_ami.id
  instance_type = var.instance_type_b
  key_name      = var.key_name_b

  network_interfaces {
  security_groups = [aws_security_group.backend_sg.id]
 }
depends_on = [aws_ami_from_instance.backend_ami]
}


#Backend auto scaling
resource "aws_autoscaling_group" "backend_asg" {
 name = "backend-asg"
 desired_capacity     = 2
  max_size             = 5
  min_size             = 1

  launch_template {
    id      = aws_launch_template.back_launch_config.id
    version = "$Latest"
  }

  vpc_zone_identifier  = [aws_subnet.private1.id,aws_subnet.private2.id]

  target_group_arns    = [aws_lb_target_group.backend_tg.arn]


 tag {
  key                 = "Name"
  value               = "back-asg-instance"
  propagate_at_launch = true
}

health_check_type         = "ELB"
health_check_grace_period = 300

  lifecycle {
    create_before_destroy = true
  }
depends_on = [aws_launch_template.back_launch_config]
}



#Backend auto scaling policy 
resource "aws_autoscaling_policy" "backend_target_tracking_policy" {
  name                   = "backend-target-tracking-policy"
  autoscaling_group_name   = aws_autoscaling_group.backend_asg.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
  predefined_metric_specification {
    predefined_metric_type = "ASGAverageCPUUtilization"
  }

  target_value = 50
 }
 depends_on = [aws_autoscaling_group.backend_asg]
}
#-----------------------------------------------------#
## Autoscalling for frontend
#ami-T-frontend 
resource "aws_ami_from_instance" "frontend_ami" {
   name  = "frontend-ami" # Ensure unique name
  source_instance_id  = aws_instance.frontend_instance.id  

 depends_on = [ aws_ami_from_instance.backend_ami,
               null_resource.backend_setup ]   
}


#Frontend Launch template
resource "aws_launch_template" "front_launch_config" {
  name          = "front_launch_config"
  image_id      = aws_ami_from_instance.frontend_ami.id
  instance_type = var.instance_type_f
  key_name      = var.key_name_f

  network_interfaces {
  security_groups = [aws_security_group.frontend_sg.id]
 }
depends_on = [aws_ami_from_instance.frontend_ami]
}


#Frontend auto scaling
resource "aws_autoscaling_group" "frontend_asg" {
 name = "frontend-asg"
 desired_capacity     = 2
  max_size             = 3
  min_size             = 1

  launch_template {
    id      = aws_launch_template.front_launch_config.id  
    version = "$Latest"
  }

  vpc_zone_identifier  = [aws_subnet.public1.id,aws_subnet.public2.id]

  target_group_arns    = [aws_lb_target_group.frontend_tg.arn]


 tag {
  key                 = "Name"
  value               = "front-asg-instance"
  propagate_at_launch = true
}
  health_check_type         = "ELB"
  health_check_grace_period = 300
  lifecycle {
    create_before_destroy = true
  }
depends_on = [aws_launch_template.front_launch_config]
}


#frontend auto scaling policy 
resource "aws_autoscaling_policy" "frontend_target_tracking_policy" {
  name                   = "frontend-target-tracking-policy"
  autoscaling_group_name   = aws_autoscaling_group.frontend_asg.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
  predefined_metric_specification {
    predefined_metric_type = "ASGAverageCPUUtilization"
  }

  target_value = 50
 }
 depends_on = [aws_autoscaling_group.frontend_asg]
}






