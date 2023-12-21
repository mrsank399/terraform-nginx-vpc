locals {
  project_name = "demo-project-ec2-module"
}

output "nginx_private_ip" {
  value = aws_instance.nginx.private_ip
}

output "nginx_instance_id" {
  value = aws_instance.nginx.id
}