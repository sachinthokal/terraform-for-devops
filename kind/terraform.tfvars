# Terraform Dyanamic Config (Non Senstive Info)

cluster_name        = "devops-cluster"
node_image          = "kindest/node:v1.30.0"
disable_default_cni = true
pod_subnet          = "192.168.0.0/16"
ingress_http_port   = 80
ingress_https_port  = 443

argocd_host_port    = 8086
vault_host_port     = 8087