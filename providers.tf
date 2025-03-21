terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.92.0"
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

data "aws_eks_cluster_auth" "shared" {
  name = aws_eks_cluster.shared.name
}

provider "kubernetes" {
  host                   = aws_eks_cluster.shared.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.shared.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.shared.token
}
