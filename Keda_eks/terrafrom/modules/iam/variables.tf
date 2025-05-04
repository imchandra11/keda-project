variable "eks_role_name" {
  description = "Name for the EKS cluster role"
  type        = string
  default     = "850075943_customEksRole"
}

variable "ec2_role_name" {
  description = "Name for the EC2 instance profile role"
  type        = string
  default     = "850075940_ec2InstanceProfile"
}

variable "tags" {
  description = "Tags to apply to IAM resources"
  type        = map(string)
  default     = {}
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket for file uploads"
  type        = string
  default     = "keda-files-bucket"
}

variable "lambda_function_name" {
  description = "Name of the S3 bucket for file uploads"
  type        = string
  default     = "keda-files-bucket"
}