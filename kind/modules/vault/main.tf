resource "helm_release" "vault" {
  name             = "vault"
  repository       = "https://helm.releases.hashicorp.com"
  chart            = "vault"
  namespace        = var.namespace
  create_namespace = true
  wait             = true
  timeout          = 600

  values = [
    yamlencode({
      server = {
        dev = {
          enabled = true
        }
        service = {
          type     = "NodePort"
          nodePort = var.node_port
        }
      }
      csi = {
        enabled = true
      }
    })
  ]
}