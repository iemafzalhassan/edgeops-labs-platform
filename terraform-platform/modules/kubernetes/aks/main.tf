# ============================================================
# Module: Kubernetes (AKS Cluster)
# ============================================================
# Provisions an AKS cluster within a $100/mo budget
# ============================================================

resource "azurerm_kubernetes_cluster" "platform" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.cluster_name
  kubernetes_version  = var.kubernetes_version

  sku_tier = "Free"

  default_node_pool {
    name           = "system"
    node_count     = 2
    vm_size        = "Standard_B2s" # $30/mo each
    vnet_subnet_id = var.system_subnet_id
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [var.identity_id]
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "basic"
  }

  tags = var.common_labels
}

resource "azurerm_kubernetes_cluster_node_pool" "workload" {
  name                  = "workload"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.platform.id
  vm_size               = "Standard_B2s"
  auto_scaling_enabled  = true
  min_count             = 1
  max_count             = 2
  vnet_subnet_id        = var.workload_subnet_id

  tags = var.common_labels
}
