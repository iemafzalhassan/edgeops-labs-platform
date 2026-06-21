# ============================================================
# EdgeOps Labs Platform - Provider Configuration
# ============================================================

# Kind provider — manages local Kubernetes clusters
provider "kind" {}

# Kubernetes provider — configured after cluster creation
# Uses the kubeconfig output from the cluster module
provider "kubernetes" {
  config_path = module.cluster.kubeconfig_path
}

# Helm provider — for deploying charts into the cluster
provider "helm" {
  kubernetes {
    config_path = module.cluster.kubeconfig_path
  }
}
