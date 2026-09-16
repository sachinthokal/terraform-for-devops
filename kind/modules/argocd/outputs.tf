output "release_name" {
  value       = helm_release.argocd.name
  description = "Helm release name for Argo CD"
}