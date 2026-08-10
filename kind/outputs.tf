output "cluster_name" {
  value       = kind_cluster.default.name
  description = "The name of the created Kind cluster"
}

output "cluster_endpoint" {
  value       = kind_cluster.default.endpoint
  description = "Kubernetes API server endpoint"
}

output "mapped_ports" {
  value       = [for p in var.port_mappings : "${p.host_port} -> NodePort ${p.container_port}"]
  description = "Summary of mapped host ports to NodePorts"
}