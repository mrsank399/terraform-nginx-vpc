########################################################################
#   Module: Subnets
#
#   @Author: Harisankar Ramachandran <mrsank@live.in>
#   @Date:   20.12.2023
#   @Version: v1.0.0
########################################################################

# eip 1
resource "aws_eip" "nat_1" {}

# eip 2
resource "aws_eip" "nat_2" {}

########################################################################
# Public Resources
########################################################################

####################################
## Subnets
####################################

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnet_cidrs[0]
  availability_zone       = var.availability_zones[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "${local.project_name}-public-subnet-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnet_cidrs[1]
  availability_zone       = var.availability_zones[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "${local.project_name}-public-subnet-2"
  }
}

####################################
## Nat Gateway
####################################

resource "aws_nat_gateway" "public_subnet_1" {
  allocation_id = aws_eip.nat_1.id
  subnet_id     = aws_subnet.public_subnet_1.id
  tags = {
    Name = "${local.project_name}-nat-gateway1"
  }
}

resource "aws_nat_gateway" "public_subnet_2" {
  allocation_id = aws_eip.nat_2.id
  subnet_id     = aws_subnet.public_subnet_2.id
  tags = {
    Name = "${local.project_name}-nat-gateway2"
  }
}

####################################
## Route Tables
####################################

resource "aws_route_table" "public_rt_1" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.route_table_cidr_block
    gateway_id = var.internet_gateway_id
  }

  tags = {
    Name = "${local.project_name}-public-route-table"
  }
}

resource "aws_route_table" "public_rt_2" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.route_table_cidr_block
    gateway_id = var.internet_gateway_id
  }

  tags = {
    Name = "${local.project_name}-public-route-table"
  }
}

####################################
## Route Table Association
####################################

resource "aws_route_table_association" "public_rta_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt_1.id
}

resource "aws_route_table_association" "public_rta_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rt_2.id
}

########################################################################
# Private Resources
########################################################################

####################################
## Subnets
####################################

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_cidrs[0]
  availability_zone = var.availability_zones[0]

  tags = {
    Name = "${local.project_name}-private-subnet-1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_cidrs[1]
  availability_zone = var.availability_zones[1]

  tags = {
    Name = "${local.project_name}-private-subnet-2"
  }
}

####################################
## Route Tables
####################################

resource "aws_route_table" "private_rt_1" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = var.route_table_cidr_block
    nat_gateway_id = aws_nat_gateway.public_subnet_1.id
  }

  tags = {
    Name = "${local.project_name}-private-route-table1"
  }
}

resource "aws_route_table" "private_rt_2" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = var.route_table_cidr_block
    nat_gateway_id = aws_nat_gateway.public_subnet_2.id
  }

  tags = {
    Name = "${local.project_name}-private-route-table2"
  }
}

####################################
## Route Table Association
####################################

resource "aws_route_table_association" "private_rta_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_rt_1.id
}

resource "aws_route_table_association" "private_rta_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_rt_2.id
}

