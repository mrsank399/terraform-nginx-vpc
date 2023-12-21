########################################################################
#   Module: VPC
#
#   @Author: Harisankar Ramachandran <mrsank@live.in>
#   @Date:   20.12.2023
#   @Version: v1.0.0
########################################################################

####################################
## VPC
####################################
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "${local.project_name}-vpc"
  }
}

####################################
## Internet Gateway
####################################
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${local.project_name}-internet-gateway"
  }
}