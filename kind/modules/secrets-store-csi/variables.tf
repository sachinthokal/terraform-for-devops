variable "namespace" {
  type        = string
  description = "Namespace to install the Secrets Store CSI Driver"
  default     = "kube-system"
}