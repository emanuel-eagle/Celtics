resource "aws_ecr_repository" "onthisday_celtics-ecr" {
  name                 = "onthisday_celtics-ecr-repo-v2"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}