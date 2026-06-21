# ============================================================
# Module: Kubernetes - Variables
# ============================================================

variable "cluster_name" {
  description = "Name of the Kind cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version for Kind node image"
  type        = string
  default     = "v1.31.4"
}

variable "worker_node_count" {
  description = "Number of worker nodes"
  type        = number
  default     = 2
}
