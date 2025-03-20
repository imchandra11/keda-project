resource "aws_eks_cluster" "keda_cluster" {
  name     = "keda-poc"
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]
  }
}
