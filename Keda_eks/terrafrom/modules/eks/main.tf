resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = var.eks_role_arn
  version  = var.cluster_version
  
  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = [aws_security_group.cluster.id]
  }
  
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

resource "aws_security_group" "cluster" {
  name        = "${var.cluster_name}-cluster-sg"
  description = "Security group for EKS cluster"
  vpc_id      = var.vpc_id
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids
  instance_types  = [var.instance_type]
  
  scaling_config {
    desired_size = 1
    max_size     = 3
    min_size     = 1
  }
  
  update_config {
    max_unavailable = 1
  }
}



# Create access entries
resource "aws_eks_access_entry" "ec2_access" {
  cluster_name  = aws_eks_cluster.this.name
  principal_arn = var.ec2_role_arn
  type          = "STANDARD"
}

resource "aws_eks_access_entry" "node_access" {
  cluster_name  = aws_eks_cluster.this.name
  principal_arn = var.node_role_arn
  type          = "EC2_LINUX"
}
