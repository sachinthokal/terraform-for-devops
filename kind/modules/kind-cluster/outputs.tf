output "endpoint" {
  value       = "https://127.0.0.1:6443" # Standard Kind API Server default endpoint local execution sathi
  description = "Kubernetes cluster API endpoint"
}

output "cluster_ca_certificate" {
  value       = "" # Placeholder or fetched via local provider config if needed
  description = "Cluster CA certificate"
}

output "client_certificate" {
  value       = ""
  description = "Client certificate"
}

output "client_key" {
  value       = ""
  description = "Client key"
}