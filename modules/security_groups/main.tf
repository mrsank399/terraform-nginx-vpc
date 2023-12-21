########################################################################
#
#   Module: Security Group
#
#   @Author: Harisankar Ramachandran
#   @Date:   20.12.2023
#   @Version: v1.0.0
#
########################################################################

####################################
##   ALB Security Group
####################################
resource "aws_security_group" "alb" {
  vpc_id      = var.vpc_id
  description = "Allow HTTP and all outbound traffic"

  ingress {
    from_port   = var.load_balancer_port
    to_port     = var.load_balancer_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all inbound traffic on the load balancer listener port"
  }

  egress {
    from_port   = var.instance_listener_port
    to_port     = var.instance_listener_port
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow outbound traffic to instances on the instance listener port"
  }

  egress {
    from_port   = var.health_check_port
    to_port     = var.health_check_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow outbound traffic to instances on the health check port"
  }

  tags = {
    Name = "${local.project_name}-alb-security-group"
  }
}

####################################
##   Nginx Security Group
####################################
resource "aws_security_group" "nginx" {
  vpc_id      = var.vpc_id
  description = "Allow HTTP and all outbound traffic"

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.alb.id]
    description     = "Allow all traffic from ALB security group"
  }

  egress {
    from_port   = var.instance_listener_port
    to_port     = var.instance_listener_port
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow outbound traffic to instances on the instance listener port"
  }

  tags = {
    Name = "${local.project_name}-nginx-security-group"
  }
}

