# SOP-004: Disaster Recovery

## Purpose
Recover the EdgeOps Labs platform from a complete cluster failure.

## Recovery Procedure

### Step 1: Recreate Cluster
```bash
make cluster-create
```

### Step 2: Verify Namespaces
```bash
kubectl get namespaces
```

### Step 3: Reinstall ArgoCD
```bash
make argocd-install
```

### Step 4: Apply Root Application
```bash
kubectl apply -f gitops-platform/bootstrap/root-app.yaml
```

### Step 5: Wait for Sync
ArgoCD will automatically reconcile all applications from Git.

```bash
argocd app list
```

## Key Principle
Because all state is in Git, recovery is simply:
1. Recreate infrastructure (OpenTofu)
2. Bootstrap GitOps (ArgoCD root app)
3. Wait for convergence
