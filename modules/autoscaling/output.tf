locals {
  project_name = "demo-project-autoscaling-module"
}

output "autoscaling_group_name_blue" {
  value = aws_autoscaling_group.as_blue[*].name
}

output "autoscaling_group_name_green" {
  value = aws_autoscaling_group.as_green[*].name
}

output "launch_template_id_blue" {
  value = aws_launch_template.lt_blue[*].id
}

output "launch_template_id_green" {
  value = aws_launch_template.lt_green[*].id
}
