terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.91.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.36.0"
    }
  }
}

provider "aws" {
  region = var.region
  assume_role {
    role_arn = var.tf_role_arn
  }
  default_tags {
    tags = {
      managed_by = "terraform"
    }
  }
}

data "aws_eks_cluster_auth" "payments" {
  name = aws_eks_cluster.payments.name
}

provider "kubernetes" {
  host                   = aws_eks_cluster.payments.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.payments.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.payments.token
}
