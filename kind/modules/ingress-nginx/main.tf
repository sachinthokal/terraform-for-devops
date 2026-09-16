resource "null_resource" "label_node" {
  provisioner "local-exec" {
    command = "kubectl label node ${var.cluster_name}-control-plane ingress-ready=true --overwrite=true"
  }
}

resource "helm_release" "ingress_nginx" {
  depends_on       = [null_resource.label_node]
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = var.namespace
  create_namespace = true
  wait             = false
  timeout          = 300

  values = [
    yamlencode({
      controller = {
        nodeSelector = {
          "ingress-ready" = "true"
        }
        tolerations = [
          {
            key      = "node-role.kubernetes.io/control-plane"
            operator = "Exists"
            effect   = "NoSchedule"
          }
        ]
        admissionWebhooks = {
          patch = {
            enabled = true
          }
        }
      }
    })
  ]
}