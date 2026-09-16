variable "cluster_name" {
  type        = string
  description = "Name of the Kind cluster"
}

variable "namespace" {
  type        = string
  description = "Namespace for Ingress Nginx"
  default     = "ingress-nginx"
}