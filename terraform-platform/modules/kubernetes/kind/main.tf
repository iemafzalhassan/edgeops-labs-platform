# ============================================================
# Module: Kubernetes (Kind Cluster)
# ============================================================
# Provisions a multi-node Kind cluster with ingress-ready
# port mappings for local platform engineering.
# ============================================================

resource "kind_cluster" "edgeops" {
  name           = var.cluster_name
  wait_for_ready = true

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    # -----------------------------------------------------------
    # Control Plane Node
    # -----------------------------------------------------------
    node {
      role = "control-plane"

      # Ingress-ready port mappings
      extra_port_mappings {
        container_port = 80
        host_port      = 80
        protocol       = "TCP"
      }

      extra_port_mappings {
        container_port = 443
        host_port      = 443
        protocol       = "TCP"
      }

      # ArgoCD UI port
      extra_port_mappings {
        container_port = 30080
        host_port      = 30080
        protocol       = "TCP"
      }

      # Label for ingress controller scheduling
      kubeadm_config_patches = [
        <<-EOT
        kind: InitConfiguration
        nodeRegistration:
          kubeletExtraArgs:
            node-labels: "ingress-ready=true"
        EOT
      ]
    }

    # -----------------------------------------------------------
    # Worker Nodes (dynamic count)
    # -----------------------------------------------------------
    dynamic "node" {
      for_each = range(var.worker_node_count)
      content {
        role = "worker"

        kubeadm_config_patches = [
          <<-EOT
          kind: JoinConfiguration
          nodeRegistration:
            kubeletExtraArgs:
              node-labels: "node-role=worker,worker-index=${node.value}"
          EOT
        ]
      }
    }
  }
}
