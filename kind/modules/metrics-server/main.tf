resource "helm_release" "metrics_server" {
  name             = "metrics-server"
  repository       = "https://kubernetes-sigs.github.io/metrics-server/"
  chart            = "metrics-server"
  namespace        = var.namespace
  create_namespace = false
  wait             = false
  timeout          = 180

  values = [
    yamlencode({
      args = [
        "--kubelet-insecure-tls=true"
      ]
    })
  ]
}