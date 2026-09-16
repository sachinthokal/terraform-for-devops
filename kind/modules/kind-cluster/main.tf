resource "random_id" "cluster_suffix" {
  byte_length = 4
}

resource "local_file" "kind_config" {
  content = templatefile("${path.module}/templates/kind-config.yaml.tftpl", {
    cluster_name        = var.cluster_name
    node_image          = var.node_image
    disable_default_cni = var.disable_default_cni
    pod_subnet          = var.pod_subnet
    ingress_http_port   = var.ingress_http_port
    ingress_https_port  = var.ingress_https_port
    port_mappings       = var.port_mappings
    argocd_host_port    = var.argocd_host_port
    vault_host_port     = var.vault_host_port
  })
  filename = "${path.root}/.terraform/kind-config-${random_id.cluster_suffix.hex}.yaml"
}

resource "null_resource" "kind_cluster" {
  triggers = {
    config_content = local_file.kind_config.content
    cluster_name   = var.cluster_name
  }

  provisioner "local-exec" {
    command = <<EOT
      if kind get clusters | grep -w "${var.cluster_name}"; then
        echo "Cluster ${var.cluster_name} already exists. Deleting..."
        kind delete cluster --name ${var.cluster_name}
      fi
      kind create cluster --config ${local_file.kind_config.filename}
    EOT
  }

  provisioner "local-exec" {
    when    = destroy
    command = "kind delete cluster --name ${self.triggers.cluster_name}"
  }
}