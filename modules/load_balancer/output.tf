locals {
  project_name = "demo-project-load_balancer-module"
}

output "load_balancer_dns_name" {
  value = aws_lb.main.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.main.arn
}