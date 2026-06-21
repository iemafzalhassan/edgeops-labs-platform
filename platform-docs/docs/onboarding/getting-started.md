# Getting Started

## Prerequisites

See [Prerequisites](prerequisites.md) for required tools.

## Quick Start

```bash
# Clone the repository
git clone https://github.com/iemafzalhassan/edgeops-labs-platform.git
cd edgeops-labs-platform

# Verify tools are installed
make check-tools

# Create the cluster
make cluster-create

# Verify everything is running
make cluster-status

# Open k9s dashboard
make cluster-dashboard
```

## What Gets Created

1. **Kind Cluster** — 3 nodes (1 control-plane + 2 workers)
2. **Namespaces** — dev, staging, prod, argocd, monitoring, observability, ingress
3. **Resource Quotas** — Per-environment CPU/memory limits
4. **Limit Ranges** — Default container resource constraints

## Next Steps

1. Install ArgoCD: `make argocd-install`
2. Deploy the demo app via GitOps
3. Set up the observability stack
