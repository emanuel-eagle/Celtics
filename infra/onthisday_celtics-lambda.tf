resource "aws_lambda_function" "onthisday_celtics-lambda" {
  function_name = var.onthisday_celtics-lambda_function_name
  role          = aws_iam_role.onthisday_celtics-iam_role.arn
  image_uri     = "${aws_ecr_repository.onthisday_celtics-ecr.repository_url}:${var.onthisday_celtics-lambda_image_tag}"
  package_type = var.onthisday_celtics-lambda_package_type
  timeout = var.onthisday_celtics-lambda_timeout
  memory_size = var.onthisday_celtics-lambda_memory
}
