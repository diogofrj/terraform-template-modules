module "labels" {
  source = "git::https://github.com/diogofrj/templates-tf-modules.git//examples/azure/labels?ref=v0.0.1"
  project      = "myapp"
  environment  = "dev"
  region       = "eastus2"
  organization = "myorg"
  CC           = "123456"
  CC_OWNER     = "myowner"
  Vertical     = "myvertical"
}


resource "azurerm_resource_group" "this" {
  name     = module.labels.resource_group_name
  location = module.labels.region
}
