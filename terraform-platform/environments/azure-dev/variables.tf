# ============================================================
# EdgeOps Labs Platform - Azure Dev Variables
# ============================================================

variable "cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
  default     = "edgeops-dev-aks"
}

variable "location" {
  description = "Azure region for the environment"
  type        = string
  default     = "southeastasia"
}

variable "resource_group_name" {
  description = "Azure Resource Group name"
  type        = string
  default     = "edgeops-labs-rg"
}

variable "kubernetes_version" {
  description = "Kubernetes version for AKS"
  type        = string
  default     = "1.33"
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
  description = "Common labels applied to all resources (also used as Azure tags)"
  type        = map(string)
  default = {
    "ManagedBy"   = "opentofu"
    "Environment" = "dev"
    "Project"     = "edgeops-labs"
  }
}
