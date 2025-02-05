resource "azurerm_resource_group" "this" {
  name     = module.labels.resource_group_name
  location = module.labels.location
}


