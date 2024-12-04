#frontend Load balancer----------------------------------------------------------
resource "aws_lb" "frontend_lb" {
  name               = var.frontend_lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.frontend_sg.id]
  subnets            = [aws_subnet.public1.id,aws_subnet.public2.id]

  tags = {
    Name = var.frontend_lb_name
  }
}
#Frontend Target group
resource "aws_lb_target_group" "frontend_tg" {
  name     = var.frontend_tg_name
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





#Backend Load balancer-----------------------------------------------------------------------------------------
resource "aws_lb" "backend_lb" {
  name               = var.backend_lb_name
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.backend_sg.id]
  subnets            = [aws_subnet.private1.id,aws_subnet.private2.id]


  tags = {
    Name = var.backend_lb_name
  }
}

#Backtend Target group
resource "aws_lb_target_group" "backend_tg" {
  name     = var.backend_tg_name
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