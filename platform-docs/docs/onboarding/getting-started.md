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

# Create the AKS cluster via OpenTofu
make cluster-create ENV=azure-dev

# Connect to the cluster
az aks get-credentials --resource-group edgeops-labs-rg --name edgeops-dev-aks --overwrite-existing

# Verify everything is running
kubectl get nodes
```

## What Gets Created

Depending on your `ENV`, the following infrastructure is provisioned:

1. **Infrastructure**: Kind cluster locally, or AKS + VNet + ACR on Azure.
2. **Namespaces** — dev, staging, prod, argocd, monitoring, observability, ingress
3. **Resource Quotas** — Per-environment CPU/memory limits
4. **Limit Ranges** — Default container resource constraints

## Next Steps

1. Install ArgoCD: `make argocd-install`
2. Deploy the demo app via GitOps
3. Set up the observability stack
