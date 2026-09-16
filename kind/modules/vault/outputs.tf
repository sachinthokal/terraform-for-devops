output "release_name" {
  value       = helm_release.vault.name
  description = "Helm release name for Vault"
}