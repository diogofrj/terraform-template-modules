module "labels" {
  source       = "git::https://github.com/diogofrj/templates-tf-modules.git//examples/azure/labels?ref=v0.0.1"
  project      = "myapp"
  environment  = "dev"
  region       = "eastus2"
  # As outras variáveis (organization, CC, CC_OWNER, Vertical) serão preenchidas com valores padrão (vazios)
}


module "aks" {
#   source = "git::https://github.com/diogofrj/templates-tf-modules.git//examples/azure/aks?ref=v0.0.1"
  source = "../"
  project      = module.labels.project
  environment  = module.labels.environment
  region       = module.labels.region
  organization = module.labels.organization
  CC           = module.labels.CC
  CC_OWNER     = module.labels.CC_OWNER
  Vertical     = module.labels.Vertical
  
  create_resource_group = true
  resource_group_name  = module.labels.resource_group_name
  location            = module.labels.region
  tags               = module.labels.tags
}