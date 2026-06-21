# SOP-003: Application Deployment

## Purpose
Deploy a new application to the EdgeOps Labs cluster via GitOps.

## Procedure

1. Create application manifests in `applications/<app-name>/k8s/`
2. Create Kustomize overlays per environment (`base/`, `overlays/dev/`, `overlays/staging/`, `overlays/prod/`)
3. Create ArgoCD Application manifest in `gitops-platform/applications/<app-name>-<env>.yaml`
4. Push to the appropriate branch (develop → dev, release → staging, main → prod)
5. ArgoCD auto-syncs the application
6. Verify: `argocd app get <app-name>-<env>`

## Application Template

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: <app-name>-<env>
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/iemafzalhassan/edgeops-labs-platform.git
    targetRevision: <branch>
    path: applications/<app-name>/k8s/overlays/<env>
  destination:
    server: https://kubernetes.default.svc
    namespace: <env>
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```
