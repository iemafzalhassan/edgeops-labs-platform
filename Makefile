# ============================================================
# EdgeOps Labs Platform - Makefile
# ============================================================
# Task runner for common platform operations
# Usage: make <target>
# ============================================================

.PHONY: help setup cluster-create cluster-delete cluster-status \
        tf-init tf-plan tf-apply tf-destroy \
        argocd-install argocd-ui argocd-password \
        docs-serve docs-build \
        lint validate clean

# Colors
GREEN  := \033[0;32m
YELLOW := \033[0;33m
RED    := \033[0;31m
CYAN   := \033[0;36m
NC     := \033[0m # No Color

# Variables
CLUSTER_NAME    ?= edgeops-labs
KUBECONFIG_PATH ?= $(HOME)/.kube/edgeops-labs.kubeconfig
TF_DIR          := terraform-platform
DOCS_DIR        := platform-docs

# ============================================================
# Help
# ============================================================

help: ## Show this help message
	@echo ""
	@echo "$(CYAN)EdgeOps Labs Platform$(NC)"
	@echo "$(CYAN)=====================$(NC)"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  $(GREEN)%-20s$(NC) %s\n", $$1, $$2}'
	@echo ""

# ============================================================
# Setup
# ============================================================

setup: ## Install all required tools
	@echo "$(CYAN)Installing required tools...$(NC)"
	brew install kind kubectl helm argocd k9s kubectx stern trivy kyverno opentofu
	pip install mkdocs-material
	@echo "$(GREEN)✓ All tools installed$(NC)"

check-tools: ## Verify all required tools are installed
	@echo "$(CYAN)Checking required tools...$(NC)"
	@command -v docker >/dev/null 2>&1 && echo "$(GREEN)✓$(NC) Docker $$(docker --version | cut -d' ' -f3)" || echo "$(RED)✗$(NC) Docker"
	@command -v kind >/dev/null 2>&1 && echo "$(GREEN)✓$(NC) Kind $$(kind version)" || echo "$(RED)✗$(NC) Kind"
	@command -v kubectl >/dev/null 2>&1 && echo "$(GREEN)✓$(NC) kubectl" || echo "$(RED)✗$(NC) kubectl"
	@command -v helm >/dev/null 2>&1 && echo "$(GREEN)✓$(NC) Helm $$(helm version --short)" || echo "$(RED)✗$(NC) Helm"
	@command -v tofu >/dev/null 2>&1 && echo "$(GREEN)✓$(NC) OpenTofu $$(tofu version | head -1)" || echo "$(RED)✗$(NC) OpenTofu"
	@command -v argocd >/dev/null 2>&1 && echo "$(GREEN)✓$(NC) ArgoCD CLI" || echo "$(RED)✗$(NC) ArgoCD CLI"
	@command -v k9s >/dev/null 2>&1 && echo "$(GREEN)✓$(NC) k9s" || echo "$(RED)✗$(NC) k9s"
	@command -v trivy >/dev/null 2>&1 && echo "$(GREEN)✓$(NC) Trivy" || echo "$(RED)✗$(NC) Trivy"
	@command -v kyverno >/dev/null 2>&1 && echo "$(GREEN)✓$(NC) Kyverno CLI" || echo "$(RED)✗$(NC) Kyverno CLI"

# ============================================================
# Cluster Operations
# ============================================================

cluster-create: ## Create the Kind cluster via OpenTofu
	@echo "$(CYAN)Creating EdgeOps Labs cluster...$(NC)"
	cd $(TF_DIR) && tofu init && tofu apply -auto-approve
	@echo "$(GREEN)✓ Cluster created successfully$(NC)"

cluster-delete: ## Delete the Kind cluster
	@echo "$(YELLOW)Deleting EdgeOps Labs cluster...$(NC)"
	cd $(TF_DIR) && tofu destroy -auto-approve
	@echo "$(GREEN)✓ Cluster deleted$(NC)"

cluster-status: ## Show cluster status
	@echo "$(CYAN)Cluster Status$(NC)"
	@echo "==============="
	@kind get clusters 2>/dev/null || echo "No clusters found"
	@echo ""
	@kubectl get nodes -o wide 2>/dev/null || echo "Cannot connect to cluster"
	@echo ""
	@kubectl get namespaces 2>/dev/null || true

cluster-dashboard: ## Open k9s terminal dashboard
	k9s

# ============================================================
# Terraform / OpenTofu Operations
# ============================================================

tf-init: ## Initialize OpenTofu
	cd $(TF_DIR) && tofu init

tf-plan: ## Plan infrastructure changes
	cd $(TF_DIR) && tofu plan

tf-apply: ## Apply infrastructure changes
	cd $(TF_DIR) && tofu apply

tf-destroy: ## Destroy all infrastructure
	cd $(TF_DIR) && tofu destroy

tf-validate: ## Validate OpenTofu configuration
	cd $(TF_DIR) && tofu validate

tf-fmt: ## Format OpenTofu files
	cd $(TF_DIR) && tofu fmt -recursive

# ============================================================
# ArgoCD Operations
# ============================================================

argocd-install: ## Install ArgoCD into the cluster
	@echo "$(CYAN)Installing ArgoCD...$(NC)"
	helm repo add argo https://argoproj.github.io/argo-helm
	helm repo update
	helm install argocd argo/argo-cd \
		--namespace argocd \
		--set server.service.type=NodePort \
		--set server.service.nodePortHttp=30080 \
		--wait
	@echo "$(GREEN)✓ ArgoCD installed$(NC)"

argocd-ui: ## Port-forward ArgoCD UI to localhost:8080
	@echo "$(CYAN)ArgoCD UI: https://localhost:8080$(NC)"
	@echo "$(YELLOW)Username: admin$(NC)"
	@echo "$(YELLOW)Password: $$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d)$(NC)"
	kubectl port-forward svc/argocd-server -n argocd 8080:443

argocd-password: ## Get ArgoCD admin password
	@kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d && echo

# ============================================================
# Documentation
# ============================================================

docs-serve: ## Serve documentation locally
	cd $(DOCS_DIR) && mkdocs serve

docs-build: ## Build documentation site
	cd $(DOCS_DIR) && mkdocs build --strict

# ============================================================
# Quality & Security
# ============================================================

lint: ## Run all linters
	@echo "$(CYAN)Running linters...$(NC)"
	cd $(TF_DIR) && tofu fmt -check -recursive
	cd $(TF_DIR) && tofu validate
	@echo "$(GREEN)✓ All linters passed$(NC)"

scan: ## Run security scans
	@echo "$(CYAN)Running security scans...$(NC)"
	trivy config $(TF_DIR)/ --severity HIGH,CRITICAL
	trivy config gitops-platform/ --severity HIGH,CRITICAL 2>/dev/null || true
	@echo "$(GREEN)✓ Security scan complete$(NC)"

validate: lint scan ## Run all validation checks

# ============================================================
# Cleanup
# ============================================================

clean: ## Clean generated files
	@echo "$(YELLOW)Cleaning generated files...$(NC)"
	rm -rf $(TF_DIR)/.terraform
	rm -f $(TF_DIR)/terraform.tfstate*
	rm -rf $(DOCS_DIR)/site
	@echo "$(GREEN)✓ Cleaned$(NC)"
