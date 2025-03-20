resource "aws_cloudwatch_event_rule" "onthisday_celtics-lambda_trigger" {
  name                = "onthisday_celtics-lambda_trigger"
  schedule_expression = var.onthisday_celtics-eventbridge_schedule
}

# Set Lambda as target for the EventBridge rule
resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.onthisday_celtics-lambda_trigger.name
  target_id = "onthisday_celtics-lambda-target"
  arn       = aws_lambda_function.onthisday_celtics-lambda.arn
}