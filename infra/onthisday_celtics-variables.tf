variable onthisday_celtics_ecr {
    default = "onthisday_celtics_lambda_repo"
}

variable onthisday_celtics-lambda_image_tag {
    type = string
}

variable onthisday_celtics-lambda_function_name {
    type = string
    default = "onthisday_celtics-lambda"
}

variable onthisday_celtics-lambda_package_type {
    type = string
    default = "Image"
}

variable onthisday_celtics-lambda_timeout {
    type = string
    default = 120
}

variable onthisday_celtics-lambda_memory {
    type = string
    default = 256
}

variable "onthisday_celtics-eventbridge_schedule" {
  description = "EventBridge schedule expression"
  type        = string
  default     = "cron(0 13 * * ? *)"  # Runs once per day at 8 AM EST (13:00 UTC)
}