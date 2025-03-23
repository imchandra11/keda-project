resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  tags = merge(var.tags, { Name = "${var.project_name}-${var.environment}-s3-bucket" })
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.this.id

  queue {
    queue_arn = var.sqs_queue_arn
    events    = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_s3_bucket_policy.allow_sqs]
}

# Define the policy to allow SQS to receive messages from S3 
resource "aws_s3_bucket_policy" "allow_sqs" {
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.allow_sqs.json
}

# Define the policy document for SQS
data "aws_iam_policy_document" "allow_sqs" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["sqs.amazonaws.com"]
    }
    actions   = ["s3:GetBucketPolicy", "s3:PutObject"]
    resources = ["arn:aws:s3:::${var.bucket_name}"]

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = [var.sqs_queue_arn]
    }
  }
}

output "bucket_name" {
  value       = aws_s3_bucket.this.id
  description = "The name of the S3 bucket."
}
