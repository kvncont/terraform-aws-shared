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
  default_tags {
    tags = {
      managed_by = "terraform"
    }
  }
}
