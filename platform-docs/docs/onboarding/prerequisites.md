# Prerequisites

## Required Tools

| Tool | Min Version | Install |
|------|-------------|---------|
| Docker Desktop | 29+ | [Download](https://www.docker.com/products/docker-desktop/) |
| Kind | 0.20+ | `brew install kind` |
| OpenTofu | 1.6+ | `brew install opentofu` |
| kubectl | 1.28+ | `brew install kubectl` |
| Helm | 3.12+ | `brew install helm` |
| ArgoCD CLI | 2.9+ | `brew install argocd` |
| k9s | 0.27+ | `brew install k9s` |
| Trivy | 0.50+ | `brew install trivy` |
| Kyverno CLI | 1.10+ | `brew install kyverno` |
| kubectx | any | `brew install kubectx` |
| stern | any | `brew install stern` |
| MkDocs Material | any | `pip install mkdocs-material` |

## One-Command Install

```bash
make setup
```

## Docker Desktop Configuration

1. Open Docker Desktop → Settings → Resources
2. Set Memory to **6 GB** minimum (8 GB recommended)
3. Set CPUs to **4** minimum
4. Apply & Restart

## Verify Installation

```bash
make check-tools
```
