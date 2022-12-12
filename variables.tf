variable "region" {
  description = "The region Terraform deploys the application"
  type        = string
  default     = "us-west-2"
}

/* ========================================
        VPC variables configuration
======================================== */
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "pynamo-vpc"
}

variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "enable_vpn_gateway" {
  description = "Enable a VPN gateway in your VPC."
  type        = bool
  default     = false
}

variable "enable_nat_gateway" {
  description = "Enable a NAT gateway in your VPC."
  type        = bool
  default     = false
}

/* ===========================================
        Subnet variables configuration
=========================================== */
variable "public_subnet_count" {
  description = "Number of public subnets."
  type        = number
  default     = 2
}

variable "public_subnet_cidr_blocks" {
  description = "Available cidr blocks for public subnets"
  type        = list(string)
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24",
    "10.0.4.0/24",
    "10.0.5.0/24",
    "10.0.6.0/24",
    "10.0.7.0/24",
    "10.0.8.0/24",
  ]
}

variable "private_subnet_count" {
  description = "Number of private subnets."
  type        = number
  default     = 2
}

variable "private_subnet_cidr_blocks" {
  description = "Available cidr blocks for private subnets"
  type        = list(string)
  default = [
    "10.0.101.0/24",
    "10.0.102.0/24",
    "10.0.103.0/24",
    "10.0.104.0/24",
    "10.0.105.0/24",
    "10.0.106.0/24",
    "10.0.107.0/24",
    "10.0.108.0/24",
  ]
}

/* ========================================
        ECS variables configuration
======================================== */
variable "ecr_repo_name" {
  description = "ECR repository name"
  type        = string
  default     = "pynamo-repository"
}

variable "image_tag_mutability" {
  description = "Image tag mutability"
  type        = string
  default     = "MUTABLE"
}

variable "ecs_cluster_name" {
  description = "ECS cluster name"
  type        = string
  default     = "pynamo-cluster"
}

variable "ecs_task_family" {
  description = "ECS task family"
  type        = string
  default     = "pynamo-task-definition"
}

/* =============================================
        For each variables configuration
============================================= */
variable "project" {
  description = "Map of project names to configuration."
  type        = map(any)

  default = {
    client-webapp = {
      public_subnets_per_vpc  = 1,
      private_subnets_per_vpc = 1,
      environment             = "dev"
    },
    internal-webapp = {
      public_subnets_per_vpc  = 1,
      private_subnets_per_vpc = 1,
      environment             = "test"
    }
  }
}

