<![CDATA[<div align="center">

# 🚀 EdgeOps Labs Platform

### Production-Inspired Cloud-Native Platform Engineering

[![Terraform](https://img.shields.io/badge/Terraform-OpenTofu-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)](https://opentofu.org)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-Kind-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)](https://kind.sigs.k8s.io)
[![ArgoCD](https://img.shields.io/badge/GitOps-ArgoCD-EF7B4D?style=for-the-badge&logo=argo&logoColor=white)](https://argo-cd.readthedocs.io)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)

*A reference architecture demonstrating Infrastructure as Code, GitOps, Platform Engineering, Kubernetes Operations, Observability, and Security — built cost-efficiently for individual engineers.*

[Architecture](#architecture) · [Getting Started](#getting-started) · [Documentation](platform-docs/) · [Contributing](CONTRIBUTING.md)

</div>

---

## 🎯 Vision

Build a production-inspired cloud-native platform that demonstrates:

- **Infrastructure as Code** — OpenTofu modules for reproducible infrastructure
- **GitOps** — ArgoCD-driven deployments from Git as single source of truth
- **Platform Engineering** — Self-service namespaces, guardrails, golden paths
- **Kubernetes Operations** — Multi-environment cluster management
- **Observability** — Prometheus, Grafana, Loki, Tempo, OpenTelemetry
- **Security** — Zero Trust, Kyverno policies, image scanning, RBAC

## 🏗️ Architecture

```
GitHub
   │
   ▼
GitHub Actions (CI)
   │
   ▼
OpenTofu (Infrastructure)
   │
   ▼
Kind Cluster (Kubernetes)
   │
   ├── dev namespace
   ├── staging namespace
   └── prod namespace
   │
   ▼
ArgoCD (GitOps)
   │
   ▼
Applications + Platform Services
   │
   ▼
Observability Stack (Prometheus/Grafana/Loki/Tempo)
```

## 📁 Repository Structure

```
edgeops-labs-platform/
│
├── terraform-platform/     # Infrastructure as Code (OpenTofu)
│   ├── modules/            # Reusable infrastructure modules
│   │   ├── network/        # Cluster networking configuration
│   │   ├── kubernetes/     # Kind cluster provisioning
│   │   ├── monitoring/     # Observability namespace + RBAC
│   │   ├── security/       # Kyverno policies, security RBAC
│   │   └── dns/            # Local DNS configuration
│   └── environments/       # Per-environment configurations
│       ├── dev/
│       ├── staging/
│       └── prod/
│
├── gitops-platform/        # GitOps configurations (ArgoCD)
│   ├── bootstrap/          # ArgoCD installation + app-of-apps
│   ├── applications/       # Application manifests
│   ├── platform-services/  # Ingress, cert-manager, etc.
│   └── environments/       # Environment-specific overlays
│       ├── dev/
│       ├── staging/
│       └── prod/
│
├── platform-docs/          # Documentation portal (MkDocs Material)
│   ├── docs/
│   │   ├── architecture/   # System design documents
│   │   ├── operations/     # SOPs and runbooks
│   │   ├── security/       # Security design and policies
│   │   ├── onboarding/     # Getting started guides
│   │   └── diagrams/       # Mermaid/architecture diagrams
│   └── mkdocs.yml
│
├── observability-stack/    # Monitoring & observability
│   ├── prometheus/         # Prometheus configuration
│   ├── grafana/            # Dashboards and datasources
│   ├── loki/               # Log aggregation
│   ├── tempo/              # Distributed tracing
│   └── opentelemetry/      # OTel collector config
│
├── applications/           # Sample microservices
│   └── demo-app/           # Reference application
│
├── automation/             # CI/CD and tooling
│   ├── .github/workflows/  # GitHub Actions pipelines
│   ├── scripts/            # Helper scripts
│   └── makefiles/          # Task automation
│
├── kind-config.yaml        # Kind cluster configuration
├── Makefile                 # Project-level task runner
└── README.md               # This file
```

## 🚀 Getting Started

### Prerequisites

| Tool | Version | Purpose |
|------|---------|---------|
| Docker Desktop | 29+ | Container runtime |
| Kind | 0.20+ | Local Kubernetes clusters |
| OpenTofu | 1.6+ | Infrastructure as Code |
| Helm | 3.12+ | Kubernetes package manager |
| kubectl | 1.28+ | Kubernetes CLI |
| ArgoCD CLI | 2.9+ | GitOps management |
| k9s | 0.27+ | Terminal K8s dashboard |

### Quick Start

```bash
# 1. Clone the repository
git clone https://github.com/iemafzalhassan/edgeops-labs-platform.git
cd edgeops-labs-platform

# 2. Install prerequisites
make setup

# 3. Create the Kind cluster
make cluster-create

# 4. Deploy platform services
make platform-deploy

# 5. Access ArgoCD UI
make argocd-ui
```

### Environment Strategy

| Environment | Branch | Namespace | Purpose |
|-------------|--------|-----------|---------|
| Development | `develop` | `dev` | Feature testing, rapid iteration |
| Staging | `release/*` | `staging` | Pre-production validation |
| Production | `main` | `prod` | Stable, production-mirror |

## 🛡️ Security

This platform implements **Zero Trust** principles:

- **Identity**: OIDC, Workload Identity
- **Secrets**: External Secrets Operator with encrypted backends
- **Admission**: Kyverno policies (no-root, require-labels, resource-limits)
- **Scanning**: Trivy for container image and IaC vulnerability scanning
- **Network**: NetworkPolicies for namespace isolation

## 📊 Observability

Full observability stack with the **LGTM** pattern:

- **L**oki — Log aggregation
- **G**rafana — Visualization and dashboards
- **T**empo — Distributed tracing
- **M**imir/Prometheus — Metrics collection

Plus **OpenTelemetry** for unified instrumentation.

## 📚 Documentation

Comprehensive documentation available at the [Platform Docs Portal](platform-docs/):

- Architecture Decision Records (ADRs)
- Standard Operating Procedures (SOPs)
- Runbooks for incident response
- Onboarding guides for new team members

## 🤝 Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## 📄 License

This project is licensed under the MIT License — see [LICENSE](LICENSE) for details.

---

<div align="center">

Built with ❤️ by [Afzal Hassan](https://github.com/iemafzalhassan)

**EdgeOps Labs** · [edgeopslabs.io](https://edgeopslabs.io) · [labs.iemafzalhassan.tech](https://labs.iemafzalhassan.tech)

</div>
]]>
