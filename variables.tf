variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "load_balancer_port" {
  description = "The port on which the load balancer will listen"
  type        = number
  default     = 80
}

variable "health_check_port" {
  description = "The port on which the load balancer will listen"
  type        = number
  default     = 80
}

variable "instance_listener_port" {
  description = "The port on which the load balancer will listen"
  type        = number
  default     = 0
}

