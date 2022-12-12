terraform {
  cloud {
    workspaces {
      name = "terraform-chatapp"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.22.0"
    }
  }

  required_version = ">= 1.2"
}