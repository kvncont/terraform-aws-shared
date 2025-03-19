resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
  depends_on = [aws_eks_node_group.payments]
}

resource "kubernetes_namespace" "backend" {
  metadata {
    name = "backend"
  }
  depends_on = [aws_eks_node_group.payments]
}
