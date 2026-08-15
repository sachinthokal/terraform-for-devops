terraform {
  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = ">= 0.5.1"
    }
  }
}

resource "kind_cluster" "default" {
  name           = var.cluster_name
  node_image     = var.node_image
  wait_for_ready = true

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    networking {
      disable_default_cni = var.disable_default_cni
      pod_subnet          = var.pod_subnet
    }

    # Control Plane Node
    node {
      role = "control-plane"

      kubeadm_config_patches = [
        <<-EOF
        kind: InitConfiguration
        nodeRegistration:
          kubeletExtraArgs:
            node-labels: "ingress-ready=true"
        EOF
      ]

      extra_port_mappings {
        container_port = 80
        host_port      = var.ingress_http_port
        protocol       = "TCP"
      }

      extra_port_mappings {
        container_port = 443
        host_port      = var.ingress_https_port
        protocol       = "TCP"
      }
    }

    # Worker Node
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