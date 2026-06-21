# SOP-001: Cluster Creation

## Purpose

Create a new EdgeOps Labs cluster (either local Kind or cloud-based AKS) with environment namespaces and proper resource management.

## Prerequisites

- [ ] Docker Desktop running with ≥6 GB RAM allocated (for local)
- [ ] Azure CLI authenticated (`az login`) (for azure-dev)
- [ ] Tools installed: `kind`, `tofu`, `kubectl`, `helm`

## Procedure

### Step 1: Verify Prerequisites

```bash
make check-tools
```

### Step 2: Initialize OpenTofu

```bash
make tf-init ENV=local
# OR
make tf-init ENV=azure-dev
```

### Step 3: Review Plan

```bash
make tf-plan ENV=local
# OR
make tf-plan ENV=azure-dev
```

Expected output:
- **Local**: 1 Kind cluster (3 nodes)
- **Azure**: 1 AKS cluster, VNet, Managed Identity, ACR
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
