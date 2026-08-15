output "cluster_name" {
  value       = module.kind_cluster.cluster_name
  description = "Name of the Dev Kind Cluster"
}

output "kubeconfig_path" {
  value       = "~/.kube/config"
  description = "Kubeconfig path"
}