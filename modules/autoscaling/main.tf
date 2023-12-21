########################################################################
#   Module: Autoscaling with Blue Green deployment
#
#   @Author: Harisankar Ramachandran <mrsank@live.in>
#   @Date:   20.12.2023
#   @Version: v1.0.0
########################################################################

####################################
## launch templates
####################################

resource "aws_launch_template" "lt_blue" {
  name          = var.template_name_blue
  count         = var.live_environment == "blue" ? 1 : 0
  image_id      = var.ec2_ami
  instance_type = var.ec2_instance_type

  iam_instance_profile {
    name = var.iam_instance_profile
  }

  vpc_security_group_ids = [var.security_group_id]

  user_data = filebase64("${path.module}/script.sh")

  metadata_options {
    http_tokens = "required"
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${local.project_name}-nginx-blue-instance"
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${local.project_name}-lt-blue"
  }
}

resource "aws_launch_template" "lt_green" {
  name          = var.template_name_green
  count         = var.live_environment == "green" ? 1 : 0
  image_id      = var.ec2_ami
  instance_type = var.ec2_instance_type

  iam_instance_profile {
    name = var.iam_instance_profile
  }

  vpc_security_group_ids = [var.security_group_id]

  user_data = filebase64("${path.module}/script.sh")

  metadata_options {
    http_tokens = "required"
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${local.project_name}-nginx-green-instance"
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${local.project_name}-lt-green"
  }
}

####################################
## autoscaling group
####################################

resource "aws_autoscaling_group" "as_blue" {
  name                      = var.autoscaling_group_name_blue
  count                     = var.live_environment == "blue" ? 1 : 0
  desired_capacity          = 1
  max_size                  = 5
  min_size                  = 1
  health_check_type         = "ELB"
  health_check_grace_period = 300
  launch_template {
    id      = aws_launch_template.lt_blue[count.index].id
    version = "$Latest"
  }
  vpc_zone_identifier = var.private_subnet_ids

  target_group_arns = [var.load_balancer_target_group_arn]
}

resource "aws_autoscaling_group" "as_green" {
  name                      = var.autoscaling_group_name_green
  count                     = var.live_environment == "green" ? 1 : 0
  desired_capacity          = 1
  max_size                  = 5
  min_size                  = 1
  health_check_type         = "ELB"
  health_check_grace_period = 300
  launch_template {
    id      = aws_launch_template.lt_green[count.index].id
    version = "$Latest"
  }
  vpc_zone_identifier = var.private_subnet_ids

  target_group_arns = [var.load_balancer_target_group_arn]
}
