# Demo Application

A simple reference application used to demonstrate the EdgeOps Labs platform capabilities.

## Purpose

- Validate the GitOps deployment pipeline
- Test environment promotion (dev → staging → prod)
- Demonstrate observability instrumentation
- Test Kyverno policy enforcement

## Stack

- **Runtime**: Go or Node.js (TBD)
- **Endpoints**: `/`, `/health`, `/metrics`
- **Container**: Multi-stage Dockerfile, non-root, distroless base

## Deployment

This application is deployed via ArgoCD using the manifests in `gitops-platform/applications/`.
