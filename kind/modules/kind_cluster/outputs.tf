output "cluster_name" {
  description = "Name of the Kind cluster"
  value       = kind_cluster.default.name
}

output "endpoint" {
  description = "Kubernetes API server endpoint"
  value       = kind_cluster.default.endpoint
}

output "client_certificate" {
  description = "Client certificate for authentication"
  value       = kind_cluster.default.client_certificate
  sensitive   = true
}

output "client_key" {
  description = "Client key for authentication"
  value       = kind_cluster.default.client_key
  sensitive   = true
}

output "cluster_ca_certificate" {
  description = "Cluster CA certificate"
  value       = kind_cluster.default.cluster_ca_certificate
  sensitive   = true
}