variable "cluster_name" {
  type        = string
  description = "Cluster name"
}

variable "node_image" {
  type        = string
  description = "Kind node image"
}

variable "disable_default_cni" {
  type        = bool
  description = "Disable default CNI"
}

variable "pod_subnet" {
  type        = string
  description = "Pod subnet CIDR"
}

variable "ingress_http_port" {
  type        = number
  description = "Host port for Ingress HTTP"
}

variable "ingress_https_port" {
  type        = number
  description = "Host port for Ingress HTTPS"
}

variable "port_mappings" {
  type = list(object({
    host_port      = number
    container_port = number
    protocol       = string
  }))
  description = "Worker node extra port mappings"
}