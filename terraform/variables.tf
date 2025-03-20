variable "region" {
  default = "us-west-2"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "eks_cluster_name" {
  default = "keda-poc"
}
