########################################################################
#   Module: EC2 Nginx Instance
#
#   @Author: Harisankar Ramachandran <mrsank@live.in>
#   @Date:   20.12.2023
#   @Version: v1.0.0
########################################################################

####################################
## EC2 Instance for Nginx
####################################
resource "aws_instance" "nginx" {
  ami                    = var.ec2_ami
  instance_type          = var.ec2_instance_type
  subnet_id              = var.private_subnet
  vpc_security_group_ids = [var.security_group]
  iam_instance_profile   = var.iam_instance_profile

  user_data = <<-EOF
              #!/bin/bash
              sudo amazon-linux-extras install -y nginx1
              systemctl start nginx
              systemctl enable nginx
              EOF

  tags = {
    Name = "${local.project_name}-nginx"
  }
}