variable "namespace" {
  type        = string
  description = "Namespace to install Vault"
  default     = "vault"
}

variable "node_port" {
  type        = number
  description = "NodePort for Vault service"
  default     = 30084
}