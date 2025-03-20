output "eks_cluster_name" {
  value = aws_eks_cluster.keda_cluster.name
}

output "sqs_queue_url" {
  value = aws_sqs_queue.keda_queue.id
}
