# Automation

This directory contains CI/CD workflows and helper scripts for the EdgeOps Labs platform.

## Structure

```
automation/
├── scripts/            # Helper scripts for common operations
│   ├── setup.sh        # One-time setup script
│   └── cleanup.sh      # Cluster cleanup script
└── makefiles/          # Modular Makefile includes
```

## GitHub Actions

CI/CD workflows are located in the repository root at `.github/workflows/`.
