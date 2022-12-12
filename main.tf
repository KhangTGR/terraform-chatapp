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
        IAM module configuration
===================================== */
data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecsTaskExecutionRole" {
  name               = "ecsTaskExecutionRole"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  role       = aws_iam_role.ecsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
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
resource "aws_ecr_repository" "foo" {
  name                 = var.ecr_repo_name
  image_tag_mutability = var.image_tag_mutability
}

resource "aws_ecs_cluster" "first_cluster" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_task_definition" "first_task_definition" {
  family                   = var.ecs_task_family
  container_definitions    = <<DEFINITION
    [
        {
            "name": "pynamo-task",
            "image": "pynamo-repository",
            "essential": true,
            "portMappings": [
                {
                    "containerPort": 8080,
                    "hostPort": 8080
                }
            ],
            "memory": 512,
            "cpu": 256
        }
    ]
    DEFINITION
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = 512
  cpu                      = 256
  execution_role_arn       = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}