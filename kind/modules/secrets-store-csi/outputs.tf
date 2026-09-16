output "release_name" {
  value       = helm_release.csi_secrets_store.name
  description = "Helm release name for Secrets Store CSI Driver"
}