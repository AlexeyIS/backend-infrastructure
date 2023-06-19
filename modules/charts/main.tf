
resource "kubernetes_namespace" "ingress-nginx" {
  metadata {
    name = "ingress-nginx"
  }
}

resource "helm_release" "nginx-ingress-controller" {
  depends_on = [kubernetes_namespace.ingress-nginx]
  name       = "nginx-ingress-controller"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.7.0"
  namespace  = kubernetes_namespace.ingress-nginx.id

  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-cross-zone-load-balancing-enabled"
    type  = "string"
    value = "true"
  }
  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
    type  = "string"
    value = "nlb"
  }
}

# resource "kubernetes_namespace" "argocd" {
#   metadata {
#     name = "argocd"
#   }
# }

resource "helm_release" "argocd" {
  # depends_on = [kubernetes_namespace.argocd]
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "5.36.1"
  # namespace  = kubernetes_namespace.argocd.id

}


