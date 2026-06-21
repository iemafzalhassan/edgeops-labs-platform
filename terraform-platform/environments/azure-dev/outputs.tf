# ============================================================
# EdgeOps Labs Platform - Azure Outputs
# ============================================================

output "cluster_name" {
  description = "Name of the AKS cluster"
  value       = module.cluster.cluster_name
}

output "cluster_endpoint" {
  description = "Kubernetes API server endpoint"
  value       = module.cluster.cluster_endpoint
}

output "registry_login_server" {
  description = "ACR login server URL"
  value       = module.registry.registry_login_server
}

output "connection_instructions" {
  description = "How to connect to the cluster"
  value       = <<-EOT
    =============================================
    EdgeOps Labs Platform - Azure Connection Info
    =============================================

    Cluster: ${module.cluster.cluster_name}
    ACR: ${module.registry.registry_login_server}

    Connect:
      az aks get-credentials --resource-group ${var.resource_group_name} --name ${module.cluster.cluster_name} --overwrite-existing
      kubectl get nodes
      kubectl get namespaces

    =============================================
  EOT
}
