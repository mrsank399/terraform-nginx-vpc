variable "vpc_id" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "load_balancer_target_group_arn" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "iam_instance_profile" {
  type = string
}

variable "ec2_ami" {
  type    = string
  default = "ami-0ef03f2a1f5df573c" # This is the ID for Amazon Linux 2 AMI
}

variable "ec2_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "live_environment" {
  type = string
}

variable "template_name_blue" {
  type = string
}

variable "template_name_green" {
  type = string
}

variable "autoscaling_group_name_green" {
  type = string
}

variable "autoscaling_group_name_blue" {
  type = string
}

