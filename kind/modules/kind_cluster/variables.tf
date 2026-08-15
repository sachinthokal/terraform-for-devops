variable "cluster_name" {
  type        = string
  description = "Name of the Kind cluster"
}

variable "node_image" {
  type        = string
  description = "Kind node image version"
  default     = "kindest/node:v1.30.0"
}

variable "disable_default_cni" {
  type        = bool
  description = "Disable default CNI for custom networking like Calico"
  default     = false
}

variable "pod_subnet" {
  type        = string
  description = "CIDR block for pod IP allocation"
  default     = "10.244.0.0/16"
}

variable "ingress_http_port" {
  type        = number
  description = "Host port mapped to control plane HTTP ingress (80)"
  default     = 80
}

variable "ingress_https_port" {
  type        = number
  description = "Host port mapped to control plane HTTPS ingress (443)"
  default     = 443
}

variable "port_mappings" {
  type = list(object({
    host_port      = number
    container_port = number
    protocol       = string
  }))
  description = "List of extra port mappings for worker node"
  default     = []
}