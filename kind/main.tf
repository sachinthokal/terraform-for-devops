resource "kind_cluster" "default" {
  name           = var.cluster_name
  node_image     = var.node_image
  wait_for_ready = true

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    # Control Plane Node
    node {
      role = "control-plane"
    }

    # Worker Node with Dynamic Extra Port Mappings
    node {
      role = "worker"

      dynamic "extra_port_mappings" {
        for_each = var.port_mappings
        content {
          host_port      = extra_port_mappings.value.host_port
          container_port = extra_port_mappings.value.container_port
          protocol       = extra_port_mappings.value.protocol
        }
      }
    }
  }
}