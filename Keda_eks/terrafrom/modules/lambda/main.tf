# modules/lambda/main.tf
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/function/lambda_function.py"
  output_path = "${path.module}/function/lambda_function.zip"
}

resource "aws_lambda_function" "this" {
  function_name    = var.lambda_function_name
  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  role             = var.lambda_role_arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.9"
  timeout          = 30
  
  environment {
    variables = {
      SQS_QUEUE_URL = var.sqs_queue_url
    }
  }
}

resource "aws_lambda_permission" "s3_trigger" {
  statement_id  = "AllowS3Invocation"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${var.s3_bucket_name}"
}


output "lambda_function_arn" {
  value = aws_lambda_function.this.arn
  description = "ARN of the Lamda function"
}