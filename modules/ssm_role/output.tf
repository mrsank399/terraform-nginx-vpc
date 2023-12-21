locals {
  project_name = "demo-project-ssm_role-module"
}

output "ssm_instance_profile" {
  value = aws_iam_instance_profile.ssm_instance_profile.name
}