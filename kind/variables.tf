variable "cluster_name" {
  type        = string
  description = "Name of the Kind cluster"
  default     = "dev-cluster"
}

variable "node_image" {
  type        = string
  description = "Kind node image version"
  default     = "kindest/node:v1.30.0"
}

variable "port_mappings" {
  type = list(object({
    host_port      = number
    container_port = number
    protocol       = string
  }))
  description = "List of extra port mappings from host to worker node"
  default = [
    { host_port = 8081, container_port = 30081, protocol = "TCP" },
    { host_port = 8082, container_port = 30082, protocol = "TCP" },
    { host_port = 8083, container_port = 30083, protocol = "TCP" },
    { host_port = 8084, container_port = 30084, protocol = "TCP" },
    { host_port = 8085, container_port = 30085, protocol = "TCP" },
  ]
}