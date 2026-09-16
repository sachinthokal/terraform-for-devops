output "cluster_endpoint" {
  value       = module.kind_cluster.endpoint
  description = "Kubernetes cluster API endpoint"
}


output "vault_host_port" {
  value       = {
    vault_port           = var.vault_host_port
    default_username     = "admin"
    default_password     = "root"
    argocd_host_url      = "https://localhost:8087/"
    }
  description = "Vault Host Port for service access"
}

output "argocd_credentials_and_management" {
  value = {
    argocd_port          = var.argocd_host_port
    default_username     = "admin"
    get_password_command = "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d"
    argocd_host_url = "https://localhost:8086/"
  }
  description = "ArgoCD initial password command and user management guidelines"
}