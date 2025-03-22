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
    helm = {
      source  = "hashicorp/helm"
      version = "3.0.0-pre2"
    }
  }
}

provider "aws" {
  region = var.region
  assume_role {
    role_arn = var.assume_role_arn
  }
  default_tags {
    tags = {
      managed_by = "terraform"
    }
  }
}

provider "kubernetes" {
  host                   = aws_eks_cluster.shared.endpoint
  token                  = data.aws_eks_cluster_auth.shared.token
  cluster_ca_certificate = base64decode(aws_eks_cluster.shared.certificate_authority[0].data)
}

provider "helm" {
  kubernetes = {
    host                   = aws_eks_cluster.shared.endpoint
    token                  = data.aws_eks_cluster_auth.shared.token
    cluster_ca_certificate = base64decode(aws_eks_cluster.shared.certificate_authority[0].data)
  }
}
