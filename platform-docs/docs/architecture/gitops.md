# GitOps Design

## Philosophy

> Git is the single source of truth for the desired state of the system.

## Flow

```mermaid
graph LR
    DEV[Developer] --> PUSH[Git Push]
    PUSH --> REPO[GitHub Repository]
    REPO --> ARGO[ArgoCD]
    ARGO --> SYNC[Sync to Cluster]
    SYNC --> VERIFY[Health Check]
    VERIFY --> DONE[Deployed ✓]
```

## App-of-Apps Pattern

ArgoCD uses the App-of-Apps pattern where a single root application manages all other applications:

```
gitops-platform/
├── bootstrap/
│   └── root-app.yaml          # Root ArgoCD application
├── applications/
│   ├── demo-app-dev.yaml      # Demo app → dev namespace
│   ├── demo-app-staging.yaml  # Demo app → staging namespace
│   └── demo-app-prod.yaml     # Demo app → prod namespace
├── platform-services/
│   ├── ingress-nginx.yaml     # NGINX Ingress Controller
│   ├── kyverno.yaml           # Policy engine
│   └── monitoring.yaml        # Observability stack
└── environments/
    ├── dev/                   # Dev-specific patches
    ├── staging/               # Staging-specific patches
    └── prod/                  # Prod-specific patches
```

## Environment Promotion

```mermaid
graph LR
    FEAT[feature branch] --> DEV[develop branch]
    DEV --> |"auto-sync"| NS_DEV[dev namespace]
    DEV --> REL[release branch]
    REL --> |"auto-sync"| NS_STG[staging namespace]
    REL --> MAIN[main branch]
    MAIN --> |"manual approve"| NS_PRD[prod namespace]
```

## Sync Policies

| Environment | Sync Mode | Prune | Self-Heal |
|-------------|-----------|-------|-----------|
| dev | Automated | Yes | Yes |
| staging | Automated | Yes | Yes |
| prod | Manual (require approval) | Yes | Yes |
