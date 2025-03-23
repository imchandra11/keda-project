variable "aws_region" {
  type        = string
  description = "AWS Region"
}

variable "project_name" {
  type        = string
  description = "Project Name"
}

variable "environment" {
  type        = string
  description = "Environment (e.g., dev, prod)"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR Block"
}

variable "public_subnets_cidr" {
  type        = list(string)
  description = "List of Public Subnet CIDRs"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of Availability Zones"
}

variable "tags" {
  type        = map(string)
  description = "Map of tags to apply to resources"
  default     = {}
}

variable "eks_cluster_version" {
  type        = string
  description = "EKS Cluster Version"
}

variable "eks_node_instance_type" {
  type        = string
  description = "Instance Type for EKS Node Group"
}

variable "eks_node_desired_capacity" {
  type        = number
  description = "Desired Capacity for EKS Node Group"
}

variable "eks_node_min_capacity" {
  type        = number
  description = "Minimum Capacity for EKS Node Group"
}

variable "eks_node_max_capacity" {
  type        = number
  description = "Maximum Capacity for EKS Node Group"
}

variable "connector_ec2_instance_type" {
  type        = string
  description = "Instance Type for Connector EC2"
}

variable "s3_bucket_name" {
  type        = string
  description = "Name of the S3 Bucket"
}

variable "sqs_queue_name" {
  type        = string
  description = "Name of the SQS Queue"
}
