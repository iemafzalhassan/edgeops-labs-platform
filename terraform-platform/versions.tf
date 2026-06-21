# ============================================================
# EdgeOps Labs Platform - Terraform Versions & Providers
# ============================================================
# Using OpenTofu (CNCF Sandbox) as the IaC engine
# Compatible with Terraform syntax, open-source licensed
# ============================================================

terraform {
  required_version = ">= 1.6.0"

  required_providers {
    # Kind cluster provisioning
    kind = {
      source  = "tehcyx/kind"
      version = "~> 0.7"
    }

    # Kubernetes resource management
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.35"
    }

    # Helm chart deployments
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.17"
    }

    # Null provider for provisioners
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }

    # Local file operations
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}
