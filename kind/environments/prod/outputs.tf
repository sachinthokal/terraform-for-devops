output "cluster_name" {
  description = "Cluster Name"
  value       = module.kind_cluster.cluster_name
}

output "argocd_url" {
  description = "URL to access ArgoCD Dashboard"
  value       = "https://localhost:8085"
}

output "vault_url" {
  description = "URL to access Vault Dashboard"
  value       = "http://localhost:8084"
}

output "argocd_admin_username" {
  description = "ArgoCD default username"
  value       = "admin"
}

output "argocd_get_password_command" {
  description = "Command to retrieve initial ArgoCD admin password"
  value       = "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d && echo"
}