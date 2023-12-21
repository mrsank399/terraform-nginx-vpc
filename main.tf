########################################################################
#   Demo Terraform file to create a VPC, Subnets, Security Groups, EC2
#   instances, Load Balancer, Autoscaling Group, Cloudfront and SSM Role
#
#   @Author: Harisankar Ramachandran <mrsank@live.in>
#   @Date:   20.12.2023
#   @Version: v1.0.0
########################################################################

####################################
# Providers
####################################

provider "aws" {
  region                   = "eu-central-1"
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
}

####################################
# Modules
####################################

module "ssm_role" {
  source = "./modules/ssm_role"
}

module "vpc" {
  source         = "./modules/vpc"
  vpc_cidr_block = var.vpc_cidr_block
}

module "subnets" {
  source              = "./modules/subnets"
  vpc_id              = module.vpc.vpc_id
  internet_gateway_id = module.vpc.internet_gateway_id
}

module "security_groups" {
  source                 = "./modules/security_groups"
  vpc_id                 = module.vpc.vpc_id
  vpc_cidr_block         = var.vpc_cidr_block
  load_balancer_port     = 80
  health_check_port      = 80
  instance_listener_port = 0
}

module "ec2" {
  source               = "./modules/ec2"
  private_subnet       = module.subnets.private_subnet_1_id
  security_group       = module.security_groups.nginx_security_group_id
  iam_instance_profile = module.ssm_role.ssm_instance_profile
  public_subnet        = module.subnets.public_subnet_1_id
}

module "load_balancer" {
  source            = "./modules/load_balancer"
  vpc_id            = module.vpc.vpc_id
  subnets           = [module.subnets.public_subnet_1_id, module.subnets.public_subnet_2_id]
  security_group_id = module.security_groups.alb_security_group_id
  ec2_instance_id   = module.ec2.nginx_instance_id
}

module "cloudfront" {
  source                 = "./modules/cloudfront"
  load_balancer_dns_name = module.load_balancer.load_balancer_dns_name
}

module "autoscaling" {
  source                         = "./modules/autoscaling"
  vpc_id                         = module.vpc.vpc_id
  security_group_id              = module.security_groups.nginx_security_group_id
  load_balancer_target_group_arn = module.load_balancer.target_group_arn
  private_subnet_ids             = [module.subnets.private_subnet_1_id, module.subnets.private_subnet_2_id]
  iam_instance_profile           = module.ssm_role.ssm_instance_profile
  live_environment               = "blue" // or "green"
  template_name_green            = "nginx-green"
  template_name_blue             = "nginx-blue"
  autoscaling_group_name_blue    = "autoscaling-blue"
  autoscaling_group_name_green   = "autoscaling-green"
}