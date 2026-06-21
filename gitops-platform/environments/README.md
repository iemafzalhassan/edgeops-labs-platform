# GitOps Platform - Environment Overlays

This directory contains environment-specific Kustomize overlays for application deployments.

## Structure

```
environments/
├── dev/         # Development overrides (lower resources, debug enabled)
├── staging/     # Staging overrides (production-like, but limited replicas)
└── prod/        # Production configuration (full resources, HA)
```

## Usage

Each environment directory contains `kustomization.yaml` files that patch base application manifests with environment-specific values (replicas, resource limits, feature flags, etc.).
