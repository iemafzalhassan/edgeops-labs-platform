# ============================================================
# EdgeOps Labs Platform - Azure Provider Configuration
# ============================================================

provider "azurerm" {
  features {}
  resource_provider_registrations = "core"
}

# Kubernetes provider — configured after cluster creation
# Uses Azure CLI authentication / managed identity
provider "kubernetes" {
  host                   = module.cluster.cluster_endpoint
  client_certificate     = base64decode(module.cluster.client_certificate)
  client_key             = base64decode(module.cluster.client_key)
  cluster_ca_certificate = base64decode(module.cluster.cluster_ca_certificate)
}

# Helm provider — for deploying charts into the cluster
provider "helm" {
  kubernetes {
    host                   = module.cluster.cluster_endpoint
    client_certificate     = base64decode(module.cluster.client_certificate)
    client_key             = base64decode(module.cluster.client_key)
    cluster_ca_certificate = base64decode(module.cluster.cluster_ca_certificate)
  }
}
