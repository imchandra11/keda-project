resource "aws_s3_bucket" "keda_bucket" {
  bucket = "keda-poc-bucket"
  force_destroy = true
}
