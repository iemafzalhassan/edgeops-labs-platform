# ============================================================
# Module: Namespaces - Outputs
# ============================================================

output "environment_namespaces" {
  description = "Map of environment namespace names"
  value       = { for k, v in kubernetes_namespace.environments : k => v.metadata[0].name }
}

output "platform_namespaces" {
  description = "Map of platform service namespace names"
  value       = { for k, v in kubernetes_namespace.platform : k => v.metadata[0].name }
}
