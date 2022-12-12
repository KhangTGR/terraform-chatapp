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