# ============================================================
# EdgeOps Labs Platform - Azure Dev Environment
# ============================================================
# Provisions the platform on Azure AKS (Phase 2)
# ============================================================

# -----------------------------------------------------------
# Module: Network (VNet + Subnets)
# -----------------------------------------------------------
module "network" {
  source = "../../modules/network/azure"

  cluster_name        = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  common_labels       = var.common_labels
}

# -----------------------------------------------------------
# Module: Identity (Managed Identity)
# -----------------------------------------------------------
module "identity" {
  source = "../../modules/identity/azure"

  cluster_name        = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  common_labels       = var.common_labels
}

# -----------------------------------------------------------
# Module: Registry (ACR)
# -----------------------------------------------------------
module "registry" {
  source = "../../modules/registry/azure"

  cluster_name        = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  aks_principal_id    = module.identity.principal_id
  common_labels       = var.common_labels

  depends_on = [module.identity]
}

# -----------------------------------------------------------
# Module: Kubernetes (AKS Cluster)
# -----------------------------------------------------------
module "cluster" {
  source = "../../modules/kubernetes/aks"

  cluster_name        = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  kubernetes_version  = var.kubernetes_version
  system_subnet_id    = module.network.system_subnet_id
  workload_subnet_id  = module.network.workload_subnet_id
  identity_id         = module.identity.identity_id
  common_labels       = var.common_labels

  depends_on = [module.network, module.identity]
}

# -----------------------------------------------------------
# Module: Namespaces (PORTABLE)
# -----------------------------------------------------------
module "namespaces" {
  source = "../../modules/namespaces"

  environments        = var.environments
  platform_namespaces = var.platform_namespaces
  common_labels       = var.common_labels

  depends_on = [module.cluster]
}

# -----------------------------------------------------------
# Module: Security (PORTABLE)
# -----------------------------------------------------------
# Uncomment in Week 4
# module "security" {
#   source = "../../modules/security"
#
#   environments  = var.environments
#   common_labels = var.common_labels
#
#   depends_on = [module.namespaces]
# }

# -----------------------------------------------------------
# Module: Monitoring (PORTABLE)
# -----------------------------------------------------------
# Uncomment in Week 4
# module "monitoring" {
#   source = "../../modules/monitoring"
#
#   enable_monitoring = var.enable_monitoring
#   common_labels     = var.common_labels
#
#   depends_on = [module.namespaces]
# }
