resource "aws_sqs_queue" "this" {
  name                      = var.queue_name
  delay_seconds             = 0
  max_message_size          = 262144
  message_retention_seconds = 345600
  receive_wait_time_seconds = 0

  tags = merge(var.tags, { Name = "${var.project_name}-${var.environment}-sqs-queue" })
}

resource "aws_sqs_queue_policy" "allow_s3" {
  queue_url = aws_sqs_queue.this.id
  policy    = data.aws_iam_policy_document.allow_s3.json
}

data "aws_iam_policy_document" "allow_s3" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }

    actions = ["sqs:SendMessage"]
    resources = [aws_sqs_queue.this.arn]

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = ["arn:aws:s3:::${var.bucket_name}"]
    }
  }
}

output "queue_url" {
  value       = aws_sqs_queue.this.id
  description = "The URL of the SQS queue."
}

output "queue_arn" {
  value       = aws_sqs_queue.this.arn
  description = "The ARN of the SQS queue."
}
