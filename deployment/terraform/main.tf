provider "aws" {
  region = "ap-south-1"  # Adjust as needed
}

resource "aws_lambda_function" "lambda_auth" {
  function_name    = "simple-node-lambda"
  runtime          = "nodejs18.x"  # Adjust based on your runtime needs
  handler          = "handler.handler"
  role             = aws_iam_role.lambda_exec.arn
  filename         = "lambda.zip"  # Terraform will upload this package

  source_code_hash = filebase64sha256("lambda.zip")  # Ensure consistent uploads
}

resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
