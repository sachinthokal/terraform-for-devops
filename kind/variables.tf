variable "cluster_name" {
  type        = string
  description = "Name of the Kind Kubernetes cluster"
  default     = "devops-cluster"
}

variable "node_image" {
  type        = string
  description = "Kind node Docker image version"
  default     = "kindest/node:v1.30.0"
}

variable "disable_default_cni" {
  type        = bool
  description = "Disable default CNI in Kind to allow installing Calico"
  default     = true
}

variable "pod_subnet" {
  type        = string
  description = "Pod IP CIDR range required for Calico"
  default     = "192.168.0.0/16"
}

variable "ingress_http_port" {
  type        = number
  description = "Host port mapping for HTTP ingress"
  default     = 80
}

variable "ingress_https_port" {
  type        = number
  description = "Host port mapping for HTTPS ingress"
  default     = 443
}

variable "port_mappings" {
  type = list(object({
    container_port = number
    host_port      = number
    protocol       = string
  }))
  description = "Additional custom port mappings for the Kind control plane"
  default = [
    { container_port = 30081, host_port = 8081, protocol = "TCP" },
    { container_port = 30082, host_port = 8082, protocol = "TCP" },
    { container_port = 30083, host_port = 8083, protocol = "TCP" },
    { container_port = 30084, host_port = 8084, protocol = "TCP" },
    { container_port = 30085, host_port = 8085, protocol = "TCP" }
  ]
}

variable "argocd_host_port" {
  type        = number
  description = "Host port for ArgoCD UI mapping"
  default     = 8086
}

variable "vault_host_port" {
  type        = number
  description = "Host port for Vault service mapping"
  default     = 8087
}