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


module "aks" {
#   source = "git::https://github.com/diogofrj/templates-tf-modules.git//examples/azure/aks?ref=v0.0.1"
  source = "../"
  project      = "myapp"
  environment  = "dev"
  region       = module.labels.region
  organization = "myorg"
  CC           = "123456"
  CC_OWNER     = "myowner"
  Vertical     = "myvertical"
  
  create_resource_group = true
  resource_group_name  = module.labels.resource_group_name
  location            = module.labels.region
  tags               = module.labels.tags
}