resource "aws_lambda_function" "nodejs_lambda" {
  function_name = var.lambda_name
  handler       = "handler.handler"
  runtime       = "nodejs18.x"
  role          = aws_iam_role.lambda_exec.arn

  filename      = "${path.module}/lambda.zip" # Ensure you zip the function before deployment
  source_code_hash = filebase64sha256("${path.module}/lambda.zip")
}
