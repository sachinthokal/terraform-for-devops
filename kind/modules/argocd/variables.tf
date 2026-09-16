variable "namespace" {
  type        = string
  description = "Namespace to install Argo CD"
  default     = "argocd"
}

variable "chart_version" {
  type        = string
  description = "Argo CD Helm chart version"
  default     = "5.53.0"
}

variable "node_port_http" {
  type        = number
  description = "NodePort for Argo CD HTTP service"
  default     = 30086
}