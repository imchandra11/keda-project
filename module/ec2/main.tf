data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "this" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id     = element(var.public_subnets, 0) # Assuming first public subnet
  vpc_security_group_ids = []
  iam_instance_profile = var.ec2_instance_profile

  user_data = templatefile("${path.module}/user_data.sh.tpl", {
    cluster_name = var.eks_cluster_name
    region = data.aws_region.current.name
  })

  tags = merge(var.tags, { Name = "${var.project_name}-${var.environment}-connector-ec2" })
}

data "aws_region" "current" {}

output "instance_id" {
  value       = aws_instance.this.id
  description = "The ID of the EC2 instance."
}
