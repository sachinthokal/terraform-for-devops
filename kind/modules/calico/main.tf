resource "null_resource" "bootstrap_calico_cni" {
  provisioner "local-exec" {
    command = <<-EOT
      helm repo add projectcalico https://docs.tigera.io/calico/charts
      helm repo update
      
      # 1. Install CRDs first using helm template or raw kubectl manifest
      kubectl apply --server-side -f https://raw.githubusercontent.com/projectcalico/calico/v3.28.0/manifests/tigera-operator.yaml
      
      # 2. Wait for operator to be ready
      kubectl wait --namespace tigera-operator --for=condition=ready pod --selector=k8s-app=tigera-operator --timeout=300s
      
      # 3. Apply custom resources (Installation)
      kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.28.0/manifests/custom-resources.yaml
    EOT
  }
}