resource "aws_s3_bucket" "this" {
  bucket = var.s3_bucket_name
}

resource "aws_s3_bucket_notification" "lambda_trigger" {
  bucket = aws_s3_bucket.this.id
  
  lambda_function {
    lambda_function_arn = var.lambda_function_arn
    events              = ["s3:ObjectCreated:*"]
    filter_suffix       = ".txt"
  }
}
