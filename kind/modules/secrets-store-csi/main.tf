resource "helm_release" "csi_secrets_store" {
  name             = "csi-secrets-store"
  repository       = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"
  chart            = "secrets-store-csi-driver"
  namespace        = var.namespace
  create_namespace = true
  wait             = false
  timeout          = 300

  values = [
    yamlencode({
      syncSecret = {
        enabled = true
      }
      enableSecretRotation = true
    })
  ]
}