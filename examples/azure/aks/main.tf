resource "azurerm_resource_group" "this" {
  name     = "rg-${var.project}-${var.environment}-${var.location}"
  location = var.location
}


