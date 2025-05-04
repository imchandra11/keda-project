terraform {
  required_providers {
    aws={
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "ldkedapoc"
    key= "backend.tfstate"
    region = "us-west-2"
  }
}

provider "aws" {
  region = var.region
}





module "vpc" {
  source = "./modules/vpc"
  
  vpc_name       = var.vpc_name
  vpc_cidr       = var.vpc_cidr
  public_subnets = var.public_subnets
  tags           = var.tags
}

module "iam" {
  source = "./modules/iam"
  
  eks_role_name  = "850075943_customEksRole"
  ec2_role_name  = "850075940_ec2InstanceProfile"
  # cluster_name   = var.cluster_name
}


module "eks" {
  source = "./modules/eks"
  
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.public_subnet_ids
  eks_role_arn    = module.iam.eks_role_arn
  node_role_arn   = module.iam.node_role_arn
  ec2_role_arn    = module.iam.ec2_role_arn
  instance_type   = var.instance_type
  
  depends_on = [module.vpc, module.iam]
}

module "ec2" {
  source = "./modules/ec2"
  
  instance_name   = "kedaconnector"
  instance_type   = var.ec2_instance_type
  subnet_id       = module.vpc.public_subnet_ids[0]
  vpc_id          = module.vpc.vpc_id
  ec2_role_name   = module.iam.ec2_instance_profile_name
  key_name        = var.key_name
  
  depends_on = [module.vpc, module.iam]
}

module "s3" {
  source = "./modules/s3"
  s3_bucket_name = var.s3_bucket_name
  lambda_function_arn = module.lambda.lambda_function_arn
}

module "sqs" {
  source = "./modules/sqs"
  queue_name = var.sqs_queue_name
}

module "lambda" {
  source = "./modules/lambda"
  lambda_function_name   = var.lambda_function_name
  s3_bucket_name  = module.s3.bucket_name
  sqs_queue_url   = module.sqs.queue_url
  lambda_role_arn = module.iam.lambda_role_arn
  
  depends_on = [module.s3, module.sqs, module.iam]
}
