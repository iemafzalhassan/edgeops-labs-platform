# ============================================================
# EdgeOps Labs Platform - Azure Dev Variables
# ============================================================

variable "cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
  default     = "edgeops-aks-dev"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "Azure Resource Group name"
  type        = string
  default     = "edgeops-labs-rg"
}

variable "kubernetes_version" {
  description = "Kubernetes version for AKS"
  type        = string
  default     = "1.30"
}

variable "environments" {
  description = "List of environments to create as Kubernetes namespaces"
  type        = list(string)
  default     = ["dev", "staging", "prod"]
}

variable "platform_namespaces" {
  description = "Platform service namespaces (ArgoCD, monitoring, etc.)"
  type        = list(string)
  default     = ["argocd", "monitoring", "observability", "ingress"]
}

variable "enable_monitoring" {
  description = "Whether to install the observability stack"
  type        = bool
  default     = false
}

variable "common_labels" {
  description = "Common labels applied to all resources"
  type        = map(string)
  default = {
    "app.kubernetes.io/managed-by" = "opentofu"
    "platform.edgeops.io/project"  = "edgeops-labs"
    "platform.edgeops.io/env"      = "dev"
  }
}
