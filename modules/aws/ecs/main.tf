resource "aws_ecr_repository" "foo" {
  name                 = var.ecr_repo_name
  image_tag_mutability = var.image_tag_mutability
}