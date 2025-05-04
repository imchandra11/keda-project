variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-west-2"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "keda-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnets"
  type        = list(object({
    name = string
    cidr = string
    az   = string
  }))
  default = [
    {
      name = "KEDA-POC1"
      cidr = "10.0.6.0/24"
      az   = "us-west-2a"
    },
    {
      name = "KEDA-POC2"
      cidr = "10.0.4.0/24"
      az   = "us-west-2b"
    }
  ]
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "keda-poc"
}

variable "cluster_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.32"
}

variable "instance_type" {
  description = "EC2 instance type for EKS nodes"
  type        = string
  default     = "m5a.xlarge"
}

variable "ec2_instance_type" {
  description = "EC2 instance type for management instance"
  type        = string
  default     = "t3.medium"
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
  default     = "keda-key"
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket for file uploads"
  type        = string
  default     = "keda-files-bucket"
}

variable "sqs_queue_name" {
  description = "Name of the SQS queue"
  type        = string
  default     = "keda-queue"
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "keda-file-processor"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {
    Project     = "KEDA-POC"
    Environment = "Development"
  }
}
