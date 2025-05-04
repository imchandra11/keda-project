resource "aws_sqs_queue" "this" {
  name                      = var.queue_name
  delay_seconds             = 0
  max_message_size          = 262144
  message_retention_seconds = 86400
  visibility_timeout_seconds = 30
}

output "sqs_queue_url" {
  value       = aws_sqs_queue.this.id
  description = "The URL of the SQS queue."
}

output "sqs_queue_arn" {
  value       = aws_sqs_queue.this.arn
  description = "The ARN of the SQS queue."
}