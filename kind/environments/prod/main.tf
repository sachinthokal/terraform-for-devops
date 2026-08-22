module "kind_cluster" {
  source = "../../modules/kind_cluster"

  cluster_name        = var.cluster_name
  node_image          = var.node_image
  disable_default_cni = var.disable_default_cni
  pod_subnet          = var.pod_subnet
  ingress_http_port   = var.ingress_http_port
  ingress_https_port  = var.ingress_https_port
  port_mappings       = var.port_mappings
}

# 1. Calico CNI Bootstrap & Wait
resource "null_resource" "bootstrap_calico_cni" {
  depends_on = [module.kind_cluster]

  provisioner "local-exec" {
    command = "kubectl apply -f https://raw.githubusercontent.com/sachinthokal/argocd-for-devops/main/cluster-addons/calico/calico.yaml && kubectl rollout status daemonset/calico-node -n kube-system --timeout=180s && kubectl rollout status deployment/calico-kube-controllers -n kube-system --timeout=180s"
  }
}

# 2. Secrets Store CSI Driver Installation
resource "helm_release" "csi_secrets_store" {
  name             = "csi-secrets-store"
  repository       = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"
  chart            = "secrets-store-csi-driver"
  namespace        = "kube-system"
  create_namespace = false
  wait             = true
  timeout          = 300

  values = [
    yamlencode({
      syncSecret = {
        enabled = true
      }
      enableSecretRotation = true
    })
  ]

  depends_on = [null_resource.bootstrap_calico_cni]
}

# 3. HashiCorp Vault & CSI Provider Installation
resource "helm_release" "vault" {
  name             = "vault"
  repository       = "https://helm.releases.hashicorp.com"
  chart            = "vault"
  namespace        = "vault"
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
          nodePort = 30084
        }
      }
      csi = {
        enabled = true
      }
    })
  ]

  depends_on = [helm_release.csi_secrets_store]
}

# 4. ArgoCD Installation
resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "5.53.0"
  namespace        = "argocd"
  create_namespace = true
  wait             = true
  timeout          = 600

  values = [
    yamlencode({
      server = {
        service = {
          type          = "NodePort"
          nodePortHttps = 30085
        }
      }
    })
  ]

  depends_on = [helm_release.vault]
}

# 5. Metrics Server Installation (Direct Kind Patch)
resource "null_resource" "install_metrics_server" {
  depends_on = [null_resource.bootstrap_calico_cni]

  provisioner "local-exec" {
    command = "kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml && kubectl patch deployment metrics-server -n kube-system --type='json' -p='[{\"op\": \"add\", \"path\": \"/spec/template/spec/containers/0/args/-\", \"value\": \"--kubelet-insecure-tls\"}]' && kubectl rollout status deployment/metrics-server -n kube-system --timeout=120s"
  }
}

# 6. Ingress-Nginx Controller Installation (Kind Clean Setup)
resource "null_resource" "install_ingress_nginx" {
  depends_on = [null_resource.bootstrap_calico_cni]

  provisioner "local-exec" {
    command = "kubectl label nodes --all ingress-ready=true --overwrite && kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml && kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission 2>/dev/null || true && kubectl delete job -n ingress-nginx --all 2>/dev/null || true && kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=180s"
  }
}