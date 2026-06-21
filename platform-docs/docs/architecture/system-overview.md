# System Overview

## Purpose

The EdgeOps Labs Platform solves the problem of demonstrating production-grade cloud-native platform engineering practices in a cost-efficient homelab environment.

## High-Level Architecture

```mermaid
graph TD
    subgraph "Developer Workflow"
        DEV[Developer] --> GIT[Git Push]
        GIT --> GH[GitHub Repository]
    end

    subgraph "CI Pipeline"
        GH --> GHA[GitHub Actions]
        GHA --> LINT[Lint & Validate]
        GHA --> SCAN[Security Scan]
        GHA --> BUILD[Build Images]
    end

    subgraph "Layer 1: Infrastructure (SWAPPABLE)"
        GHA --> TF[OpenTofu]
        TF --> KIND[Local: Kind Cluster]
        TF --> AZURE[Azure: AKS Cluster]
        TF --> AWS[AWS: EKS Cluster]
    end

    subgraph "Kubernetes Cluster"
        KIND --> CP[Control Plane]
        KIND --> W1[Worker 1]
        KIND --> W2[Worker 2]

        subgraph "Namespaces"
            NS_DEV[dev]
            NS_STG[staging]
            NS_PRD[prod]
            NS_ARGO[argocd]
            NS_MON[monitoring]
            NS_ING[ingress]
        end
    end

    subgraph "GitOps Layer"
        GH --> ARGO[ArgoCD]
        ARGO --> NS_DEV
        ARGO --> NS_STG
        ARGO --> NS_PRD
    end

    subgraph "Observability"
        PROM[Prometheus] --> GRAF[Grafana]
        LOKI[Loki] --> GRAF
        TEMPO[Tempo] --> GRAF
        OTEL[OpenTelemetry] --> PROM
        OTEL --> LOKI
        OTEL --> TEMPO
    end
```

## Design Principles

1. **Infrastructure as Code**: All infrastructure is defined declaratively in OpenTofu
2. **GitOps**: Git is the single source of truth for desired state
3. **Separation of Concerns**: Infrastructure, applications, and platform services are managed independently
4. **Least Privilege**: RBAC and network policies enforce minimal access
5. **Observability by Default**: Every component is instrumented
6. **Progressive Delivery**: Changes flow through dev → staging → prod

## Platform Portability Roadmap

This platform is intentionally designed to demonstrate cloud-agnostic architecture. The infrastructure layer is cleanly decoupled from the Kubernetes workload layer, allowing the platform to migrate seamlessly across providers.

**The Multi-Cloud Journey:**
1. **Phase 1 (Complete)**: Local validation via `Kind`
2. **Phase 2 (Complete)**: Cloud deployment via `Azure AKS`
3. **Phase 3 (Future)**: Provider abstraction expansion to `AWS EKS`

*This explicitly demonstrates Platform Engineering maturity by enabling workloads to port seamlessly from local dev to Azure and eventually AWS, governed purely by GitOps and OpenTofu provider abstractions.*

## Component Responsibilities

| Component | Manages | Does NOT Manage |
|-----------|---------|-----------------|
| OpenTofu | Cluster, namespaces, RBAC, quotas | Application deployments |
| ArgoCD | Application lifecycle, environment promotion | Infrastructure provisioning |
| GitHub Actions | CI (lint, test, scan, build) | CD (handled by ArgoCD) |
| Kyverno | Policy enforcement, admission control | Application logic |
| Prometheus | Metrics collection, alerting rules | Log storage |
| Grafana | Visualization, dashboards | Data collection |
