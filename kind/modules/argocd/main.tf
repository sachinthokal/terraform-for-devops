resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = var.chart_version
  namespace        = var.namespace
  create_namespace = true

  wait    = true
  timeout = 600

  values = [
    yamlencode({
      server = {
        service = {
          type          = "NodePort"
          nodePortHttp  = var.node_port_http
          nodePortHttps = 30088
        }
      }
    })
  ]
}