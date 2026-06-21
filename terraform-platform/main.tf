# ============================================================
# EdgeOps Labs Platform - Main Configuration
# ============================================================
# Orchestrates all modules for the homelab platform
# ============================================================

# -----------------------------------------------------------
# Module: Kind Cluster (Network + Kubernetes combined)
# -----------------------------------------------------------
module "cluster" {
  source = "./modules/kubernetes"

  cluster_name       = var.cluster_name
  kubernetes_version = var.kubernetes_version
  worker_node_count  = var.worker_node_count
}

# -----------------------------------------------------------
# Module: Namespaces (Environment + Platform)
# -----------------------------------------------------------
module "namespaces" {
  source = "./modules/namespaces"

  environments        = var.environments
  platform_namespaces = var.platform_namespaces
  common_labels       = var.common_labels

  depends_on = [module.cluster]
}

# -----------------------------------------------------------
# Module: Security (Kyverno policies + RBAC)
# -----------------------------------------------------------
# Uncomment in Week 4
# module "security" {
#   source = "./modules/security"
#
#   environments  = var.environments
#   common_labels = var.common_labels
#
#   depends_on = [module.namespaces]
# }

# -----------------------------------------------------------
# Module: Monitoring (Prometheus + Grafana + Loki)
# -----------------------------------------------------------
# Uncomment in Week 4
# module "monitoring" {
#   source = "./modules/monitoring"
#
#   enable_monitoring = var.enable_monitoring
#   common_labels     = var.common_labels
#
#   depends_on = [module.namespaces]
# }
