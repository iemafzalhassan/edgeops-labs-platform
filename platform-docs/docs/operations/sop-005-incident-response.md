# SOP-005: Incident Response

## Purpose
Structured response procedure for platform incidents.

## Severity Levels

| Level | Description | Response Time |
|-------|-------------|---------------|
| P1 | Cluster down, all apps affected | Immediate |
| P2 | Single environment down | < 30 min |
| P3 | Single app degraded | < 1 hour |
| P4 | Non-critical issue | Next business day |

## Incident Response Steps

### 1. Assess
```bash
make cluster-status
kubectl get pods --all-namespaces | grep -v Running
kubectl get events --all-namespaces --sort-by='.lastTimestamp' | tail -20
```

### 2. Diagnose
```bash
# Check node health
kubectl describe nodes

# Check pod logs
stern -n <namespace> <pod-pattern>

# Check resource usage
kubectl top nodes
kubectl top pods -n <namespace>
```

### 3. Resolve
- Apply fix via Git (GitOps self-heals)
- Or manual intervention for infrastructure issues

### 4. Post-mortem
Document in `platform-docs/docs/operations/postmortems/`
