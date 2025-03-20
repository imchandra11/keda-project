resource "aws_sqs_queue" "keda_queue" {
  name                      = "keda-poc-queue"
  delay_seconds             = 0
  visibility_timeout_seconds = 30
  message_retention_seconds = 86400
}
