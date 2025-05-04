variable "s3_bucket_name" {
  description = "Name of the S3 bucket for file uploads"
  type        = string
  default     = "keda-files-bucket"
}

variable "lambda_function_arn" {
  type        = string
  description = "The ARN of the lambda_function to send notifications to."
}