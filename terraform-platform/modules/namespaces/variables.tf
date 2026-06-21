# ============================================================
# Module: Namespaces - Variables
# ============================================================

variable "environments" {
  description = "List of environment namespaces to create"
  type        = list(string)
  default     = ["dev", "staging", "prod"]
}

variable "platform_namespaces" {
  description = "List of platform service namespaces to create"
  type        = list(string)
  default     = ["argocd", "monitoring", "observability", "ingress"]
}

variable "common_labels" {
  description = "Common labels for all namespace resources"
  type        = map(string)
  default     = {}
}
