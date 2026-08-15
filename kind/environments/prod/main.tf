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

resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  wait             = false
  timeout = 300
  version          = "5.53.0"

  set {
    name  = "server.service.type"
    value = "NodePort"
  }

  set {
    name  = "server.service.nodePortHttps"
    value = "30085"
  }

  depends_on = [null_resource.bootstrap_calico_cni]
}

resource "null_resource" "bootstrap_calico_cni" {
  depends_on = [module.kind_cluster]

  provisioner "local-exec" {
    command = "kubectl apply -f https://raw.githubusercontent.com/sachinthokal/argocd-for-devops/main/cluster-addons/calico/calico.yaml"
  }
}