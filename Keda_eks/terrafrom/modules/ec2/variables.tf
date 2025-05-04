variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID to launch the instance in"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the instance"
  type        = string
}

variable "ec2_role_name" {
  description = "IAM instance profile name"
  type        = string
}

variable "key_name" {
  description = "Key pair name for SSH"
  type        = string
}
