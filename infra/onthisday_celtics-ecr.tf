module "ecr" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "2.3.1"
  repository_name = var.onthisday_celtics_ecr
}