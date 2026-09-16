provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "kind-${var.cluster_name}"
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "kind-${var.cluster_name}"
  }
}

provider "kubectl" {
  config_path      = "~/.kube/config"
  config_context   = "kind-${var.cluster_name}"
  load_config_file = true
}