resource "kubernetes_namespace" "backend" {
  metadata {
    name = "backend"
  }
  depends_on = [aws_eks_node_group.shared]
}

resource "helm_release" "argocd" {
  name             = "argocd"
  chart            = "argo-cd"
  repository       = "https://argoproj.github.io/argo-helm"
  version          = "7.8.13"
  namespace        = "argocd"
  create_namespace = true
}
