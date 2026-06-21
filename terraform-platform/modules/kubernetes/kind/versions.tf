# ============================================================
# Module: Kubernetes
# ============================================================
# Provisions a multi-node Kind cluster for EdgeOps Labs.
# Includes ingress-ready port mappings and dynamic worker nodes.
# ============================================================

terraform {
  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "~> 0.7"
    }
  }
}
