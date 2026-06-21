# SOP-002: Namespace Creation

## Purpose
Create a new application namespace with resource quotas, limit ranges, and proper labeling.

## Procedure

1. Add namespace name to `terraform-platform/variables.tf` under `environments` or `platform_namespaces`
2. Run `make tf-plan` to verify changes
3. Run `make tf-apply` to create the namespace
4. Verify: `kubectl get namespace <name> --show-labels`

## Resource Quotas

All namespaces automatically receive:
- CPU and memory limits
- Pod count limits
- Service count limits
