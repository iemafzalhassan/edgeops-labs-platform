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
  kubernetes_version  = "1.33.12"
  support_plan        = "KubernetesOfficial"

  sku_tier = "Free"

  default_node_pool {
    name                 = "system"
    node_count           = 1
    vm_size              = "Standard_B2s_v2" # Supported in southeastasia, 2 vCPUs
    vnet_subnet_id       = var.system_subnet_id
    orchestrator_version = "1.33.12"
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [var.identity_id]
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    service_cidr      = "172.16.0.0/16"
    dns_service_ip    = "172.16.0.10"
  }

  tags = var.common_labels
}

