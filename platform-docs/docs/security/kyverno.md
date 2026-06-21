# Kyverno Rules

Kyverno is our policy engine for Kubernetes admission control. Policies are defined as Kubernetes resources and enforced at admission time.

## Active Policies

> Policies will be progressively enabled over the 4-week roadmap.

### Week 1: require-labels (Audit Mode)
### Week 2: require-resource-limits (Enforce Mode)
### Week 3: disallow-root-containers (Enforce Mode)
### Week 4: restrict-image-tags (Enforce Mode)

## Policy Examples

See `terraform-platform/modules/security/` for policy definitions.
