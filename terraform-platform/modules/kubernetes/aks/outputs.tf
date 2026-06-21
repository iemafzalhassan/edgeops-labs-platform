output "cluster_name" {
  value = azurerm_kubernetes_cluster.platform.name
}

output "cluster_endpoint" {
  value = azurerm_kubernetes_cluster.platform.kube_config.0.host
}

output "kubeconfig_path" {
  value = "" # In AKS, we typically use the native data source or CLI, but to maintain contract:
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.platform.kube_config.0.client_certificate
}

output "client_key" {
  value = azurerm_kubernetes_cluster.platform.kube_config.0.client_key
}

output "cluster_ca_certificate" {
  value = azurerm_kubernetes_cluster.platform.kube_config.0.cluster_ca_certificate
}
