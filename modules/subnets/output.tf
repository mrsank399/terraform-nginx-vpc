locals {
  project_name = "demo-project-subnet-module"
}

output "public_subnet_1_id" {
  value = aws_subnet.public_subnet_1.id
}

output "public_subnet_2_id" {
  value = aws_subnet.public_subnet_2.id
}

output "private_subnet_1_id" {
  value = aws_subnet.private_subnet_1.id
}

output "private_subnet_2_id" {
  value = aws_subnet.private_subnet_2.id
}

output "public_route_table_1_id" {
  value = aws_route_table.public_rt_1.id
}

output "public_route_table_2_id" {
  value = aws_route_table.public_rt_2.id
}

output "public_subnets" {
  value = [var.public_subnet_cidrs[0], var.public_subnet_cidrs[1]]
}

output "private_subnets" {
  value = [var.private_subnet_cidrs[0], var.private_subnet_cidrs[1]]
}