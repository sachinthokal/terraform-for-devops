output "release_name" {
  value       = helm_release.metrics_server.name
  description = "Helm release name for Metrics Server"
}