variable "vpc_id" {
  type        = string
  description = "The ID of the VPC to create the EC2 instance in."
}

variable "public_subnets" {
  type        = list(string)
  description = "A list of subnet IDs to use for the EC2 instance."
}

variable "ec2_instance_profile" {
  type        = string
  description = "The name of the IAM instance profile to attach to the EC2 instance."
}

variable "eks_cluster_name" {
  type        = string
  description = "The name of the EKS cluster."
}

variable "instance_type" {
  type        = string
  description = "The instance type for the EC2 instance."
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
