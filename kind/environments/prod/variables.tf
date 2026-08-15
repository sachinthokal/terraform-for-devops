variable "cluster_name" {
  type        = string
  description = "Name of the Kind cluster"
}

variable "node_image" {
  type        = string
  description = "Node image version"
}

variable "disable_default_cni" {
  type        = bool
  description = "Disable default CNI"
}

variable "pod_subnet" {
  type        = string
  description = "Pod CIDR"
}

variable "ingress_http_port" {
  type        = number
  description = "Host HTTP ingress port"
}

variable "ingress_https_port" {
  type        = number
  description = "Host HTTPS ingress port"
}

variable "port_mappings" {
  type = list(object({
    host_port      = number
    container_port = number
    protocol       = string
  }))
  description = "Worker node port mappings"
}