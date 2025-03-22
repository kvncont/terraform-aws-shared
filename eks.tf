data "aws_eks_cluster_versions" "shared" {}

data "aws_eks_cluster_auth" "shared" {
  name = aws_eks_cluster.shared.name
}

resource "aws_eks_cluster" "shared" {
  name     = "shared"
  role_arn = aws_iam_role.shared_eks.arn
  version  = data.aws_eks_cluster_versions.shared.cluster_versions[0].cluster_version

  access_config {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }

  vpc_config {
    subnet_ids = aws_subnet.public.*.id
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks,
  ]
}

resource "aws_eks_node_group" "shared" {
  cluster_name    = aws_eks_cluster.shared.name
  node_group_name = "group-1"
  node_role_arn   = aws_iam_role.shared_worker.arn
  subnet_ids      = aws_subnet.public.*.id

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  instance_types = ["t3.medium"]

  depends_on = [
    aws_iam_role_policy_attachment.worker,
    aws_iam_role_policy_attachment.cni,
    aws_iam_role_policy_attachment.ecr_read_only
  ]
}

data "aws_eks_addon_version" "eks_pod_identity_agent" {
  addon_name         = "eks-pod-identity-agent"
  kubernetes_version = aws_eks_cluster.shared.version
  most_recent        = true
}

resource "aws_eks_addon" "eks_pod_identity_agent" {
  cluster_name  = aws_eks_cluster.shared.name
  addon_name    = data.aws_eks_addon_version.eks_pod_identity_agent.addon_name
  addon_version = data.aws_eks_addon_version.eks_pod_identity_agent.version
}

# resource "aws_eks_access_entry" "user" {
#   cluster_name  = aws_eks_cluster.shared.name
#   principal_arn = "arn:aws:iam::<account-id>:user/<user-name>"
#   type          = "STANDARD"
# }

# resource "aws_eks_access_policy_association" "user" {
#   cluster_name  = aws_eks_cluster.shared.name
#   principal_arn = "arn:aws:iam::<account-id>:user/<user-name>"
#   policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

#   access_scope {
#     type = "cluster"
#   }
# }