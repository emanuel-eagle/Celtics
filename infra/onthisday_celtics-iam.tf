data "aws_iam_policy_document" "onthisday_celtics-assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "onthisday_celtics-iam_role" {
  name  = "onthisday_celtics-ecr-permissions"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "ecr_policy_attachment" {
  role       = aws_iam_role.onthisday_celtics-iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPullOnly"
}

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

# Permission for EventBridge to invoke Lambda
resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.onthisday_celtics-lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.lambda_trigger.arn
}