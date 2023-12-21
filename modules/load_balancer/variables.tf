variable "vpc_id" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "alb_name" {
  type    = string
  default = "nginx-alb"
}

variable "alb_target_group_name" {
  type    = string
  default = "nginx-target-group"
}

// use this when test against EC2 instance
#variable "ec2_instance_id" {
#  type = string
#}