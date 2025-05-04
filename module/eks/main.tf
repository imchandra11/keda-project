data "aws_caller_identity" "current" {}

data "aws_eks_cluster" "this" {
  name = var.eks_cluster_name
}


# Extracts the TLS certificate thumbprint from the EKS cluster's OIDC issuer URL, used for IAM integration.
data "tls_certificate" "eks" {
  url = data.aws_eks_cluster.this.identity[0].oidc[0].issuer
}

resource "aws_eks_cluster" "this" {
  name     = var.eks_cluster_name
  role_arn = var.eks_cluster_role_arn
  version  = var.eks_cluster_version

  vpc_config {
    subnet_ids              = var.public_subnets
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  depends_on = [module.iam]
  tags = merge(var.tags, { Name = "${var.project_name}-${var.environment}-eks-cluster" })
}

resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.project_name}-${var.environment}-node-group"
  node_role_arn   = var.eks_node_role_arn
  subnet_ids      = var.public_subnets
  instance_types  = [var.eks_node_instance_type]

  scaling_config {
    desired_size = var.eks_node_desired_capacity
    max_size     = var.eks_node_max_capacity
    min_size     = var.eks_node_min_capacity
  }

  # Ensure that we don't unintentionally modify the desired size via terraform
  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

  depends_on = [aws_eks_cluster.this]
  tags = merge(var.tags, { Name = "${var.project_name}-${var.environment}-eks-nodegroup" })
}

resource "aws_iam_openid_connect_provider" "eks" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]
  url             = data.aws_eks_cluster.this.identity[0].oidc[0].issuer

  tags = var.tags
}

# Create EKS access entries for authentication
resource "aws_eks_access_entry" "connector" {
  cluster_name  = aws_eks_cluster.this.name
  principal_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.project_name}-${var.environment}-connector-role"
  type          = "STANDARD"
  # authentication_mode = "API_AND_CONFIG_MAP"
  tags = var.tags
}

output "cluster_name" {
  value       = aws_eks_cluster.this.name
  description = "The name of the EKS cluster"
}

output "cluster_endpoint" {
  value       = aws_eks_cluster.this.endpoint
  description = "The endpoint of the EKS cluster"
}

output "cluster_certificate_authority_data" {
  value = aws_eks_cluster.this.certificate_authority[0].data
}
