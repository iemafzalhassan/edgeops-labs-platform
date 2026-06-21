# ============================================================
# EdgeOps Labs Platform - Backend Configuration
# ============================================================
# Using local backend for homelab development
# Migrate to remote (S3/GCS/Azure Blob) when moving to cloud
# ============================================================

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
