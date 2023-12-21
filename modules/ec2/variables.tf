variable "ec2_ami" {
  type    = string
  default = "ami-0ef03f2a1f5df573c" # This is the ID for Amazon Linux 2 AMI
}

variable "ec2_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "private_subnet" {
  type = string
}

variable "public_subnet" {
  type = string
}

variable "security_group" {
  type = string
}

variable "iam_instance_profile" {
  type = string
}