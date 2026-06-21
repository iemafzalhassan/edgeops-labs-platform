# SOP-001: Cluster Creation

## Purpose

Create a new EdgeOps Labs Kind cluster with multi-node configuration, ingress support, and environment namespaces.

## Prerequisites

- [ ] Docker Desktop running with ≥6 GB RAM allocated
- [ ] Tools installed: `kind`, `tofu`, `kubectl`, `helm`
- [ ] No existing Kind cluster named `edgeops-labs`

## Procedure

### Step 1: Verify Prerequisites

```bash
make check-tools
```

### Step 2: Initialize OpenTofu

```bash
make tf-init
```

### Step 3: Review Plan

```bash
make tf-plan
```

Expected output:
- 1 Kind cluster (3 nodes: 1 control-plane + 2 workers)
- 7 Kubernetes namespaces (dev, staging, prod, argocd, monitoring, observability, ingress)
- 3 Resource quotas (one per environment)
- 3 Limit ranges (one per environment)

### Step 4: Apply

```bash
make tf-apply
```

### Step 5: Verify

```bash
make cluster-status
```

Expected:
- 3 nodes in `Ready` state
- All namespaces created
- kubectl can connect to the cluster

## Rollback

```bash
make cluster-delete
```

## Troubleshooting

| Issue | Cause | Resolution |
|-------|-------|------------|
| Port 80 already in use | Another service on port 80 | Stop the conflicting service |
| Node stuck in NotReady | Docker resource limits | Increase Docker Desktop memory |
| Terraform provider error | Provider cache issue | `rm -rf .terraform && make tf-init` |
