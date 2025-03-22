variable "region" {
  type        = string
  description = "The AWS region to deploy to"
}

variable "assume_role_arn" {
  type        = string
  description = "ARN Role to assume for terraform"
}