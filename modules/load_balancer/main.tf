########################################################################
#    Module: Load Balancer
#
#   @Author: Harisankar Ramachandran <mrsank@live.in>
#   @Date:   20.12.2023
#   @Version: v1.0.0
########################################################################

####################################
## load balancer
####################################

resource "aws_lb" "main" {
  name                       = var.alb_name
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.security_group_id]
  subnets                    = var.subnets
  drop_invalid_header_fields = true

  tags = {
    Name = "${local.project_name}-load-balancer"
  }
}

####################################
## target group
####################################

resource "aws_lb_target_group" "main" {
  name     = var.alb_target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = {
    Name = "${local.project_name}-target-group"
  }
}

####################################
## listener for load balancer
####################################

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

####################################
## attach instance to load balancer - testing SSM and ALB against EC2
####################################

#resource "aws_lb_target_group_attachment" "attach_ec2" {
#  target_group_arn = aws_lb_target_group.main.arn
#  target_id        = var.ec2_instance_id
#  port             = 80
#}
