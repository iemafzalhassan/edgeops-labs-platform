variable "cluster_name" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "aks_principal_id" { type = string }
variable "common_labels" { type = map(string) }

resource "azurerm_container_registry" "platform" {
  name                = replace("${var.cluster_name}acr", "-", "")
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic" # $5/month
  admin_enabled       = false
  tags                = var.common_labels
}

# Grant AKS identity pull access to ACR
resource "azurerm_role_assignment" "aks_acr_pull" {
  principal_id                     = var.aks_principal_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.platform.id
  skip_service_principal_aad_check = true
}
