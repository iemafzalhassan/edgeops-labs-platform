# ============================================================
# Module: Kubernetes - Outputs
# ============================================================

output "cluster_name" {
  description = "Name of the provisioned Kind cluster"
  value       = kind_cluster.edgeops.name
}

output "kubeconfig_path" {
  description = "Path to the kubeconfig file"
  value       = kind_cluster.edgeops.kubeconfig_path
}

output "cluster_endpoint" {
  description = "Kubernetes API server endpoint"
  value       = kind_cluster.edgeops.endpoint
}
