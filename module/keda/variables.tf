variable "eks_cluster_name" {
  type        = string
  description = "The name of the EKS cluster."
}

variable "keda_role_arn" {
  type        = string
  description = "The ARN of the IAM role for KEDA to access SQS."
}

variable "sqs_queue_url" {
  type        = string
  description = "The URL of the SQS queue."
}

variable "aws_region" {
  type        = string
  description = "The AWS region."
}
