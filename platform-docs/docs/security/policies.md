# Security Policies

## Admission Policies (Kyverno)

### Policy: Require Labels
All resources must have `app.kubernetes.io/name` and `app.kubernetes.io/managed-by` labels.

### Policy: Require Resource Limits
All containers must specify CPU and memory requests and limits.

### Policy: Non-Root Containers
Containers must not run as root (UID 0).

### Policy: No Latest Tag
Container images must not use the `:latest` tag.

## RBAC Strategy

| Role | Scope | Permissions |
|------|-------|-------------|
| Platform Admin | Cluster | Full access |
| Developer | Namespace (dev) | Deploy, view logs |
| Viewer | Namespace (all) | Read-only |

## Network Policies

Default deny all ingress per namespace, with explicit allow rules for:
- Ingress controller traffic
- Intra-namespace communication
- Prometheus metric scraping
