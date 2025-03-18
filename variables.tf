variable "region" {
  type        = string
  description = "The AWS region to deploy to"
  default     = "us-east-1"
}

# variable "tags" {
#   type = map(string)
#   description = "Tags to apply to all resources"
#   default = {
#     Name = "EKS"
#   }
# }