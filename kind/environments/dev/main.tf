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