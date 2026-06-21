# Azure VNet and Subnets
resource "azurerm_virtual_network" "platform" {
  name                = "${var.cluster_name}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.common_labels
}

resource "azurerm_subnet" "system" {
  name                 = "system-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.platform.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "workload" {
  name                 = "workload-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.platform.name
  address_prefixes     = ["10.0.2.0/24"]
}
