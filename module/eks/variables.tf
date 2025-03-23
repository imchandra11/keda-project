variable "vpc_id" {
  type        = string
  description = "The ID of the VPC to create the EKS cluster in."
}

variable "public_subnets" {
  type        = list(string)
  description = "A list of subnet IDs to use for the EKS cluster."
}

variable "eks_cluster_role_arn" {
  type        = string
  description = "The ARN of the IAM role for the EKS cluster."
}

variable "eks_node_role_arn" {
  type        = string
  description = "The ARN of the IAM role for the EKS nodes."
}

variable "eks_cluster_version" {
  type        = string
  description = "The Kubernetes version for the EKS cluster."
}

variable "eks_node_instance_type" {
  type        = string
  description = "The instance type for the EKS nodes."
}

variable "eks_node_desired_capacity" {
  type        = number
  description = "The desired number of EKS nodes."
}

variable "eks_node_min_capacity" {
  type        = number
  description = "The minimum number of EKS nodes."
}

variable "eks_node_max_capacity" {
  type        = number
  description = "The maximum number of EKS nodes."
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

variable "eks_cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}
