module "kind_cluster" {
  source = "./modules/kind-cluster"

  cluster_name        = var.cluster_name
  node_image          = var.node_image
  disable_default_cni = var.disable_default_cni
  pod_subnet          = var.pod_subnet
  ingress_http_port   = var.ingress_http_port
  ingress_https_port  = var.ingress_https_port
  port_mappings       = var.port_mappings
  argocd_host_port    = var.argocd_host_port
  vault_host_port     = var.vault_host_port
}

# 1. Calico CNI Bootstrap & Wait
module "calico" {
  source     = "./modules/calico"
  depends_on = [module.kind_cluster]
}

# 2. Secrets Store CSI Driver Installation
module "csi_secrets_store" {
  source     = "./modules/secrets-store-csi"
  namespace  = "kube-system"
  depends_on = [module.calico]
}

# 3. HashiCorp Vault & CSI Provider Installation
module "vault" {
  source     = "./modules/vault"
  namespace  = "vault"
  node_port  = 30087
  depends_on = [module.csi_secrets_store]
}

# 4. ArgoCD Installation
module "argocd" {
  source          = "./modules/argocd"
  namespace       = "argocd"
  chart_version   = "5.53.0"
  node_port_http = 30086
  depends_on      = [module.vault]
}

# 5. Metrics Server Installation
module "metrics_server" {
  source     = "./modules/metrics-server"
  depends_on = [module.calico]
}

# 6. Ingress Nginx Controller Installation
module "ingress_nginx" {
  source       = "./modules/ingress-nginx"
  cluster_name = var.cluster_name
  depends_on   = [module.calico]
}