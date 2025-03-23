resource "kubernetes_namespace" "keda" {
  metadata {
    name = "keda"
  }
}

resource "helm_release" "keda" {
  name       = "keda"
  repository = "https://kedacore.github.io/charts"
  chart      = "keda"
  namespace  = kubernetes_namespace.keda.metadata[0].name
  version    = "2.12.0"

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = var.keda_role_arn
  }

  set {
    name  = "serviceAccount.name"
    value = "keda-operator"
  }

  depends_on = [kubernetes_namespace.keda]
}

resource "kubernetes_manifest" "scaled_object" {
  manifest = {
    apiVersion = "keda.sh/v1alpha1"
    kind       = "ScaledObject"
    metadata = {
      name      = "sqs-scaler"
      namespace = "default"
    }
    spec = {
      scaleTargetRef = {
        apiVersion = "apps/v1"
        kind       = "Deployment"
        name       = "keda-app-deployment"
      }
      pollingInterval = 30
      cooldownPeriod  = 300
      minReplicaCount = 1
      maxReplicaCount = 10
      triggers = [
        {
          type = "aws-sqs-queue"
          metadata = {
            queueURL       = var.sqs_queue_url
            queueLength    = "5"
            awsRegion      = var.aws_region
            identityOwner  = "operator"
          }
        }
      ]
    }
  }

  depends_on = [helm_release.keda]
}



