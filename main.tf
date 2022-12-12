provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {
  state = "available"

  #   filter {
  #     name   = "zone-type"
  #     values = ["availability-zone"]
  #   }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"

  name = "main-vpc"
  cidr = var.vpc_cidr_block

  azs             = data.aws_availability_zones.available.names
  private_subnets = slice(var.private_subnet_cidr_blocks, 0, var.private_subnet_count)
  public_subnets  = slice(var.public_subnet_cidr_blocks, 0, var.public_subnet_count)

  enable_nat_gateway = var.enable_nat_gateway
  enable_vpn_gateway = var.enable_vpn_gateway

  map_public_ip_on_launch = false
}
