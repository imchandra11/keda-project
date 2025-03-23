# modules/ecr/main.tf
resource "aws_ecr_repository" "this" {
  name                 = var.repository_name
  image_tag_mutability = "MUTABLE" # or IMMUTABLE

  tags = merge(var.tags, { Name = "${var.project_name}-${var.environment}-ecr-repo" })
}

resource "aws_ecr_lifecycle_policy" "this" {
  repository = aws_ecr_repository.this.name
  policy     = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "Keep last 10 images"
      selection = {
        tagStatus   = "any"
        countType   = "imageCountMoreThan"
        countNumber = 10
      },
      action = {
        type = "expire"
      }
    }]
  })
}

output "repository_url" {
  value       = aws_ecr_repository.this.repository_url
  description = "The URL of the ECR repository"
}

output "repository_name" {
  value       = aws_ecr_repository.this.name
  description = "The name of the ECR repository"
}
