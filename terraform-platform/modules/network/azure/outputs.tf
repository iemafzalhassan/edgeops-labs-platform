output "vnet_id" { value = azurerm_virtual_network.platform.id }
output "system_subnet_id" { value = azurerm_subnet.system.id }
output "workload_subnet_id" { value = azurerm_subnet.workload.id }
