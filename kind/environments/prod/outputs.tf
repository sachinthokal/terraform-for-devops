output "cluster_name" {
  description = "Cluster Name"
  value       = module.kind_cluster.cluster_name
}

output "argocd_url" {
  description = "URL to access ArgoCD Dashboard"
  value       = "https://localhost:8085"
}