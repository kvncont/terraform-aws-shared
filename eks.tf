resource "aws_eks_cluster" "payments" {
  name     = "payments"
  role_arn = aws_iam_role.payments_eks.arn
  version  = "1.31"

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

resource "aws_eks_node_group" "payments" {
  cluster_name    = aws_eks_cluster.payments.name
  node_group_name = "group-1"
  node_role_arn   = aws_iam_role.payments_worker.arn
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
