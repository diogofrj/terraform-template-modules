locals {
  # https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations
  naming_convention = {
    subscription_name             = lower("sub-${var.project}-${var.environment}-${var.region}")
    resource_group_name           = lower("rg-${var.project}-${var.environment}-${var.region}")
    storage_name                  = lower("sa${var.project}${var.environment}${var.region}")
    server_name                   = lower("vm-${var.project}-${var.environment}-${var.region}")
    aks_name                      = lower("aks-${var.project}-${var.environment}-${var.region}")
    redis_cache_name              = lower("redis-${var.project}-${var.environment}-${var.region}")
    
    postgresql_flexible_srv_name  = lower("psql-${var.project}-${var.environment}-${var.region}")
    workspace_name                = lower("law-${var.project}-${var.environment}-${var.region}")
    key_vault_name                = lower("kv-${var.project}-${var.environment}-${var.region}")
    private_dns_zone_name         = lower("privatelink.postgres.database.azure.com")
    private_dns_zone_blob         = lower("privatelink.blob.core.windows.net")
    private_dns_zone_file         = lower("privatelink.file.core.windows.net")
    private_dns_zone_sql          = lower("privatelink.database.windows.net")
    private_dns_zone_redis        = lower("privatelink.redis.cache.windows.net")
    private_dns_zone_vault        = lower("privatelink.vaultcore.azure.net")
    private_dns_zone_webapp       = lower("privatelink.azurewebsites.net")
    private_dns_zone_eventhub     = lower("privatelink.servicebus.windows.net")
    private_dns_zone_kubernetes   = lower("privatelink.${var.region}.azmk8s.io")
    private_dns_zone_containerapps = lower("privatelink.${var.region}.azurecontainerapps.io")
    private_dns_zone_containerregistry = lower("privatelink.${var.region}.data.azurecr.io")
    route_table                   = lower("rt-${var.project}-${var.environment}-${var.region}")
    nsg_name                      = lower("nsg-${var.project}-${var.environment}-${var.region}")
    automation                    = lower("aa-${var.project}-${var.environment}-${var.region}")
    eventhub_namespace            = lower("evhns-${var.project}-${var.environment}-${var.region}")
    containerapp_name             = lower("ca-${var.project}-${var.environment}-${var.region}")
    containerapp_environment_name = lower("cae-${var.project}-${var.environment}-${var.region}")
    
    ## NETWORKING
    public_subnet_name            = lower("snet-${var.project}-${var.environment}-${var.region}-pub")
    private_subnet_name           = lower("snet-${var.project}-${var.environment}-${var.region}-priv")
    vnet_name                     = lower("vnet-${var.project}-${var.environment}-${var.region}")
    db_subnet_name      = lower("snet-${var.project}-${var.environment}-${var.region}-db")
    gateway_subnet_name = lower("snet-${var.project}-${var.environment}-${var.region}-gw")
    dns_resolver_name            = lower("dnspr-${var.project}-${var.environment}-${var.region}")
  }
tags = {
    organization = var.organization
    project      = var.project
    environment  = var.environment
    CC           = var.CC
    CC_OWNER     = var.CC_OWNER
    Vertical     = var.Vertical
  }
}

