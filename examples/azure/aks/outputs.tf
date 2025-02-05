output "resource_group_name" {
  description = "Nome do grupo de recursos"
  value       = try(azurerm_resource_group.rg[0].name, data.azurerm_resource_group.rgrp[0].name)
}

output "resource_group_id" {
  description = "ID do grupo de recursos"
  value       = try(azurerm_resource_group.rg[0].id, data.azurerm_resource_group.rgrp[0].id)
}

output "resource_group_location" {
  description = "Localização do grupo de recursos"
  value       = try(azurerm_resource_group.rg[0].location, data.azurerm_resource_group.rgrp[0].location)
}
