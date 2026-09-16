output "release_name" {
  value       = helm_release.ingress_nginx.name
  description = "Helm release name for Ingress Nginx"
}