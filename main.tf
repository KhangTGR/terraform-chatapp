provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {
  state = "available"

  filter {
    name   = "zone-type"
    values = ["availability-zone"]
  }
}

/* =====================================
        VPC module configuration
===================================== */
# module "vpc" {
#   source  = "terraform-aws-modules/vpc/aws"
#   version = "3.14.2"

#   name = var.vpc_name
#   for_each = var.project

#   cidr = var.vpc_cidr_block

#   azs             = data.aws_availability_zones.available.names
#   private_subnets = slice(var.private_subnet_cidr_blocks, 0, each.value.private_subnets_per_vpc)
#   public_subnets  = slice(var.public_subnet_cidr_blocks, 0, each.value.public_subnets_per_vpc)

#   enable_nat_gateway = var.enable_nat_gateway
#   enable_vpn_gateway = var.enable_vpn_gateway

#   map_public_ip_on_launch = false
# }

/* =====================================
        ECS module configuration
===================================== */
module "aws_ecr_repository" {
  resource = "./module/aws/ecs"
}