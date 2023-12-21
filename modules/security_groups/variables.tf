variable "vpc_id" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}

variable "load_balancer_port" {
  type = string
}

variable "instance_listener_port" {
  type = string
}

variable "health_check_port" {
  type = string
}
