aws_region = "us-west-2"
project_name = "keda-project"
environment = "dev"
vpc_cidr = "10.0.0.0/16"
public_subnets_cidr = ["10.0.1.0/24", "10.0.2.0/24"]
availability_zones = ["us-west-2a", "us-west-2b"]
tags = {
  Owner = "Your Name"
  Project = "KEDA Project"
}

eks_cluster_version = "1.24"
eks_node_instance_type = "t3.medium"
eks_node_desired_capacity = 2
eks_node_min_capacity = 1
eks_node_max_capacity = 5

connector_ec2_instance_type = "t3.micro"

s3_bucket_name = "keda-project-bucket"
sqs_queue_name = "keda-project-queue"
