variable "vpc_cidr" {
  type        = string
  default = "10.0.0.0/16"

  description = "The CIDR block for the VPC."
}

variable "public_subnets_cidr" {
  type        = list(string)
  default = [ "10.0.6.0/16","10.0.4.0/16" ]

  description = "A list of CIDR blocks for the public subnets."
}

variable "availability_zones" {
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b"]

  description = "A list of availability zones for the subnets."
}

variable "project_name" {
  type        = string
  description = "KEDA"
}

variable "environment" {
  type        = string
  description = "dev"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to apply to all resources."
  default     = {}
}
