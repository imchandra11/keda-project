variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for EKS"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for EKS"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs for EKS"
  type        = list(string)
}

variable "eks_role_arn" {
  description = "IAM Role ARN for EKS cluster"
  type        = string
}

variable "node_role_arn" {
  description = "IAM Role ARN for EKS node group"
  type        = string
}

variable "ec2_role_arn" {
  description = "IAM Role ARN for EC2 access"
  type        = string
}

variable "instance_type" {
  description = "Instance type for EKS node group"
  type        = string
}
