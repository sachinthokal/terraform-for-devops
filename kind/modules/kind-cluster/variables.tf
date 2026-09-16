variable "cluster_name" {
  type        = string
  description = "Name of the Kind cluster"
}

variable "node_image" {
  type        = string
  description = "Kind node Docker image version"
}

variable "disable_default_cni" {
  type        = bool
  description = "Whether to disable default CNI"
}

variable "pod_subnet" {
  type        = string
  description = "Pod subnet CIDR"
}

variable "ingress_http_port" {
  type        = number
  description = "Host HTTP port mapping"
}

variable "ingress_https_port" {
  type        = number
  description = "Host HTTPS port mapping"
}

variable "port_mappings" {
  type = list(object({
    container_port = number
    host_port      = number
    protocol       = string
  }))
  description = "Custom port mappings"
}

variable "argocd_host_port" {
  type = number
}

variable "vault_host_port" {
  type = number
}