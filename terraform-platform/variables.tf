# ============================================================
# EdgeOps Labs Platform - Root Variables
# ============================================================

variable "cluster_name" {
  description = "Name of the Kind cluster"
  type        = string
  default     = "edgeops-labs"
}

variable "kubernetes_version" {
  description = "Kubernetes version for Kind nodes (as Kind node image tag)"
  type        = string
  default     = "v1.31.4"
}

variable "worker_node_count" {
  description = "Number of worker nodes in the Kind cluster"
  type        = number
  default     = 2

  validation {
    condition     = var.worker_node_count >= 1 && var.worker_node_count <= 4
    error_message = "Worker node count must be between 1 and 4 for homelab (16GB RAM constraint)."
  }
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

variable "enable_ingress" {
  description = "Whether to install an ingress controller"
  type        = bool
  default     = true
}

variable "ingress_controller" {
  description = "Which ingress controller to use"
  type        = string
  default     = "nginx"

  validation {
    condition     = contains(["nginx", "traefik"], var.ingress_controller)
    error_message = "Ingress controller must be 'nginx' or 'traefik'."
  }
}

variable "enable_argocd" {
  description = "Whether to install ArgoCD"
  type        = bool
  default     = true
}

variable "enable_monitoring" {
  description = "Whether to install the observability stack"
  type        = bool
  default     = false # Enable in Week 4
}

variable "common_labels" {
  description = "Common labels applied to all resources"
  type        = map(string)
  default = {
    "app.kubernetes.io/managed-by" = "opentofu"
    "platform.edgeops.io/project"  = "edgeops-labs"
  }
}
