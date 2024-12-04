# # backend AMi-t
# resource "aws_ami_from_instance" "backend_ami" {
#   name = "Backami-T"
#   source_instance_id  = aws_instance.backend-ec2.id  

#   depends_on = [aws_instance.backend-ec2]
# }

# #Backend Launch template
# resource "aws_launch_template" "back_LT" {
#   name          = "backend-T"
#   image_id      = aws_ami_from_instance.backend_ami.id
#   instance_type = var.instance_type_b
#   key_name      = var.key_name_b

#   network_interfaces {
#   security_groups = [aws_security_group.backend-sg-T.id]
#  }
# depends_on = [aws_ami_from_instance.backend_ami]
# }


# #Backend auto scaling
# resource "aws_autoscaling_group" "backend_asg" {
#  name = "backend-asg"
#  desired_capacity     = 2
#   max_size             = 5
#   min_size             = 1

#   launch_template {
#     id      = aws_launch_template.back_LT.id
#     version = "$Latest"
#   }

#   vpc_zone_identifier  = [aws_subnet.privateT3.id,aws_subnet.privateT4.id]

#   target_group_arns    = [aws_lb_target_group.TG-backend.arn]


#  tag {
#   key                 = "Name"
#   value               = "back-asg-T"
#   propagate_at_launch = true
# }

# health_check_type         = "ELB"
# health_check_grace_period = 300

#   lifecycle {
#     create_before_destroy = true
#   }
# depends_on = [aws_launch_template.back_LT]
# }



# #Backend auto scaling policy 
# resource "aws_autoscaling_policy" "backend_target_tracking_policy" {
#   name                   = "backend-target-tracking-policy"
#   autoscaling_group_name   = aws_autoscaling_group.backend_asg.name
#   policy_type            = "TargetTrackingScaling"

#   target_tracking_configuration {
#   predefined_metric_specification {
#     predefined_metric_type = "ASGAverageCPUUtilization"
#   }

#   target_value = 70
#  }
#  depends_on = [aws_autoscaling_group.backend_asg]
# }