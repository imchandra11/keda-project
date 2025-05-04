# main.tf
module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnets_cidr = var.public_subnets_cidr
  availability_zones  = var.availability_zones
  project_name        = var.project_name
  environment         = var.environment
  tags                = var.tags
}

module "iam" {
  source       = "./modules/iam"
  project_name = var.project_name
  environment  = var.environment
  tags         = var.tags
}

module "eks" {
  source                    = "./modules/eks"
  vpc_id                    = module.vpc.vpc_id
  public_subnets            = module.vpc.public_subnets
  eks_cluster_role_arn      = module.iam.eks_cluster_role_arn
  eks_node_role_arn         = module.iam.eks_node_role_arn
  eks_cluster_version       = var.eks_cluster_version
  eks_node_instance_type    = var.eks_node_instance_type
  eks_node_desired_capacity = var.eks_node_desired_capacity
  eks_node_min_capacity     = var.eks_node_min_capacity
  eks_node_max_capacity     = var.eks_node_max_capacity
  project_name              = var.project_name
  environment               = var.environment
  tags                      = var.tags
}

module "ec2" {
  source                = "./modules/ec2"
  vpc_id                = module.vpc.vpc_id
  public_subnets        = module.vpc.public_subnets
  ec2_instance_profile  = module.iam.connector_instance_profile_name
  eks_cluster_name      = module.eks.cluster_name
  instance_type         = var.connector_ec2_instance_type
  project_name          = var.project_name
  environment           = var.environment
  tags                  = var.tags
}

module "s3" {
  source       = "./modules/s3"
  bucket_name  = var.s3_bucket_name
  sqs_queue_arn = module.sqs.queue_arn
  project_name = var.project_name
  environment  = var.environment
  tags         = var.tags
}

module "sqs" {
  source       = "./modules/sqs"
  queue_name   = var.sqs_queue_name
  bucket_name  = var.s3_bucket_name
  project_name = var.project_name
  environment  = var.environment
  tags         = var.tags
}

module "keda" {
  source           = "./modules/keda"
  eks_cluster_name = module.eks.cluster_name
  keda_role_arn    = module.iam.keda_role_arn
  sqs_queue_url    = module.sqs.queue_url
  aws_region       = var.aws_region
  ecr_repository_url = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.project_name}/kedaecr"
  depends_on       = [module.eks]
}

data "aws_caller_identity" "current" {}



module "ecr" {
  source         = "./modules/ecr"
  repository_name = "${var.project_name}/kedaecr" 
  project_name   = var.project_name
  environment    = var.environment
  tags           = var.tags
}
