resource "aws_ecr_repository" "onthisday_celtics-ecr-module" {
  name                 = "onthisday_celtics-ecr-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}