# Runbooks

## Common Operations

### Check Cluster Health
```bash
make cluster-status
kubectl get nodes -o wide
kubectl get pods --all-namespaces
```

### View Pod Logs
```bash
# Single pod
kubectl logs -n <namespace> <pod-name> -f

# Multi-pod with stern
stern -n <namespace> <pod-pattern>
```

### Open k9s Dashboard
```bash
make cluster-dashboard
```

### Access ArgoCD UI
```bash
make argocd-ui
# Open: https://localhost:8080
```

### Force ArgoCD Sync
```bash
argocd app sync <app-name>
```

### Scale a Deployment
```bash
kubectl scale deployment <name> -n <namespace> --replicas=<count>
```

### Check Resource Usage
```bash
kubectl top nodes
kubectl top pods -n <namespace>
```
