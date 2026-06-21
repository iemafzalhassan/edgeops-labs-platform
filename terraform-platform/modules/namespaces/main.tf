# ============================================================
# Module: Namespaces
# ============================================================
# Creates environment and platform service namespaces with
# consistent labeling and resource quotas.
# ============================================================

# -----------------------------------------------------------
# Environment Namespaces (dev, staging, prod)
# -----------------------------------------------------------
resource "kubernetes_namespace" "environments" {
  for_each = toset(var.environments)

  metadata {
    name = each.value

    labels = merge(var.common_labels, {
      "platform.edgeops.io/environment" = each.value
      "platform.edgeops.io/type"        = "application"
    })

    annotations = {
      "platform.edgeops.io/description" = "Application namespace for ${each.value} environment"
      "platform.edgeops.io/owner"       = "platform-team"
    }
  }
}

# -----------------------------------------------------------
# Platform Service Namespaces (argocd, monitoring, etc.)
# -----------------------------------------------------------
resource "kubernetes_namespace" "platform" {
  for_each = toset(var.platform_namespaces)

  metadata {
    name = each.value

    labels = merge(var.common_labels, {
      "platform.edgeops.io/type"    = "platform-service"
      "platform.edgeops.io/service" = each.value
    })

    annotations = {
      "platform.edgeops.io/description" = "Platform service namespace: ${each.value}"
      "platform.edgeops.io/owner"       = "platform-team"
    }
  }
}

# -----------------------------------------------------------
# Resource Quotas per Environment
# -----------------------------------------------------------
resource "kubernetes_resource_quota" "environment_quotas" {
  for_each = toset(var.environments)

  metadata {
    name      = "${each.value}-resource-quota"
    namespace = kubernetes_namespace.environments[each.value].metadata[0].name

    labels = var.common_labels
  }

  spec {
    hard = {
      "requests.cpu"    = each.value == "prod" ? "2" : "1"
      "requests.memory" = each.value == "prod" ? "2Gi" : "1Gi"
      "limits.cpu"      = each.value == "prod" ? "4" : "2"
      "limits.memory"   = each.value == "prod" ? "4Gi" : "2Gi"
      "pods"            = each.value == "prod" ? "20" : "10"
      "services"        = "10"
    }
  }
}

# -----------------------------------------------------------
# Limit Ranges per Environment
# -----------------------------------------------------------
resource "kubernetes_limit_range" "environment_limits" {
  for_each = toset(var.environments)

  metadata {
    name      = "${each.value}-limit-range"
    namespace = kubernetes_namespace.environments[each.value].metadata[0].name

    labels = var.common_labels
  }

  spec {
    limit {
      type = "Container"

      default = {
        cpu    = "250m"
        memory = "256Mi"
      }

      default_request = {
        cpu    = "100m"
        memory = "128Mi"
      }

      max = {
        cpu    = "1"
        memory = "1Gi"
      }

      min = {
        cpu    = "50m"
        memory = "64Mi"
      }
    }
  }
}
