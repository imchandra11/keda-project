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
