locals {
  project_name = "demo-project-security_group-module"
}

output "alb_security_group_id" {
  value = aws_security_group.alb.id
}

output "nginx_security_group_id" {
  value = aws_security_group.nginx.id
}

