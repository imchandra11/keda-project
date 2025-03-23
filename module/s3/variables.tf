variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket."
}

variable "sqs_queue_arn" {
  type        = string
  description = "The ARN of the SQS queue to send notifications to."
}

variable "project_name" {
  type        = string
  description = "The name of the project."
}

variable "environment" {
  type        = string
  description = "The environment (e.g., 'dev', 'prod')."
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to apply to all resources."
  default     = {}
}
