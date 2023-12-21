variable "vpc_id" {
  type = string
}

variable "internet_gateway_id" {
  type = string
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "availability_zones" {
  type    = list(string)
  default = ["eu-central-1a", "eu-central-1b"]
}

variable "route_table_cidr_block" {
  default = "0.0.0.0/0"
  type    = string
}
