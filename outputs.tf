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
# AKS outputs

output "cluster_name" {
  description = "Cluster Name"
  value       = azurerm_kubernetes_cluster.aks_cluster.name
}
output "default_ng_rg_name" {
  description = "Default Node Group Resource Group Name"
  value       = azurerm_kubernetes_cluster.aks_cluster.node_resource_group
}
output "kubernetes_cluster_id" {
  description = "kubernetes cluster id"
  value       = azurerm_kubernetes_cluster.aks_cluster.id
}
output "host" {
  description = "host"
  value       = azurerm_kubernetes_cluster.aks_cluster.kube_config[0].host
}
output "client_certificate" {
  description = "client_certificate"
  value       = base64decode(azurerm_kubernetes_cluster.aks_cluster.kube_config[0].client_certificate)
}
output "client_key" {
  description = "client_key"
  value       = base64decode(azurerm_kubernetes_cluster.aks_cluster.kube_config[0].client_key)
}
output "cluster_ca_certificate" {
  description = "cluster_ca_certificate"
  value       = base64decode(azurerm_kubernetes_cluster.aks_cluster.kube_config[0].cluster_ca_certificate)
}