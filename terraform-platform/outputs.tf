# ============================================================
# EdgeOps Labs Platform - Outputs
# ============================================================

output "cluster_name" {
  description = "Name of the Kind cluster"
  value       = module.cluster.cluster_name
}

output "kubeconfig_path" {
  description = "Path to the generated kubeconfig file"
  value       = module.cluster.kubeconfig_path
}

output "cluster_endpoint" {
  description = "Kubernetes API server endpoint"
  value       = module.cluster.cluster_endpoint
}

output "environment_namespaces" {
  description = "Created environment namespaces"
  value       = module.namespaces.environment_namespaces
}

output "platform_namespaces" {
  description = "Created platform service namespaces"
  value       = module.namespaces.platform_namespaces
}

output "connection_instructions" {
  description = "How to connect to the cluster"
  value       = <<-EOT
    =============================================
    EdgeOps Labs Platform - Connection Info
    =============================================

    Cluster: ${module.cluster.cluster_name}
    Kubeconfig: ${module.cluster.kubeconfig_path}

    Connect:
      export KUBECONFIG=${module.cluster.kubeconfig_path}
      kubectl get nodes
      kubectl get namespaces

    Dashboard:
      k9s --kubeconfig ${module.cluster.kubeconfig_path}

    =============================================
  EOT
}
