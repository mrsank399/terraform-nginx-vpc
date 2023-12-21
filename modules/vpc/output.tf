locals {
  project_name = "demo-project-vpc-module"
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "vpc_arn" {
  value = aws_vpc.main.arn
}

output "internet_gateway_id" {
  value = aws_internet_gateway.main.id
}
