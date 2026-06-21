# Contributing to EdgeOps Labs Platform

Thank you for your interest in contributing to EdgeOps Labs Platform! This document provides guidelines and best practices for contributions.

## 🌳 Branching Strategy

```
feature/*  →  develop  →  main
              (dev)       (prod)
```

| Branch | Environment | Purpose |
|--------|-------------|---------|
| `feature/*` | — | New features and experiments |
| `develop` | `dev` | Integration branch |
| `release/*` | `staging` | Pre-production validation |
| `main` | `prod` | Production-stable |

## 📝 Commit Convention

We use [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

### Types

| Type | Description |
|------|-------------|
| `feat` | New feature |
| `fix` | Bug fix |
| `docs` | Documentation only |
| `infra` | Infrastructure changes (Terraform, K8s) |
| `ci` | CI/CD pipeline changes |
| `refactor` | Code refactoring |
| `test` | Adding or updating tests |
| `chore` | Maintenance tasks |
| `security` | Security improvements |

### Scopes

| Scope | Description |
|-------|-------------|
| `terraform` | Infrastructure as Code |
| `k8s` | Kubernetes manifests |
| `gitops` | ArgoCD configurations |
| `docs` | Documentation portal |
| `observability` | Monitoring stack |
| `ci` | GitHub Actions |

### Examples

```bash
feat(terraform): add network module for Kind cluster
fix(k8s): correct resource limits on demo-app deployment
docs(architecture): add networking design document
infra(gitops): configure ArgoCD app-of-apps pattern
ci(actions): add terraform validate workflow
security(k8s): add Kyverno policy for non-root containers
```

## 🔄 Pull Request Process

1. Create a feature branch from `develop`
2. Make changes following the conventions above
3. Ensure all CI checks pass:
   - `terraform validate`
   - `helm lint`
   - `trivy config .`
   - `mkdocs build --strict`
4. Create a PR to `develop` with a clear description
5. Request review

## 📂 Directory Guidelines

- **terraform-platform/**: Only infrastructure definitions
- **gitops-platform/**: Only ArgoCD and deployment manifests
- **platform-docs/**: Only documentation
- **observability-stack/**: Only monitoring configs
- **applications/**: Only application source code
- **automation/**: Only CI/CD and scripts

## 🛡️ Security

- Never commit secrets, keys, or credentials
- Use `.env.example` for environment variable templates
- All container images must pass Trivy scanning
- Follow the principle of least privilege for RBAC

## 📄 License

By contributing, you agree that your contributions will be licensed under the MIT License.
