# Observability Stack

This directory contains configurations for the EdgeOps Labs observability stack.

## Components

| Component | Purpose | Status |
|-----------|---------|--------|
| Prometheus | Metrics collection | Week 4 |
| Grafana | Visualization & dashboards | Week 4 |
| Loki | Log aggregation | Week 4 |
| Tempo | Distributed tracing | Week 4 |
| OpenTelemetry | Unified instrumentation | Week 4 |

## Directory Structure

```
observability-stack/
├── prometheus/         # Prometheus configuration & rules
├── grafana/            # Dashboard JSON definitions
│   └── dashboards/     # Pre-built dashboards
├── loki/               # Loki configuration
├── tempo/              # Tempo configuration
└── opentelemetry/      # OTel Collector config
```

## Deployment

The observability stack will be deployed via Helm charts managed by ArgoCD (GitOps).
