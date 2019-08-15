provider "azurerm" {
  subscription_id               = "${var.AZURE_SUBSCRIPTION_ID}"
  tenant_id                     = "${var.AZURE_TENANT_ID}"
  client_id                     = "${var.AZURE_CLIENT_ID}"
  client_secret                 = "${var.AZURE_CLIENT_SECRET}"
}

resource "azurerm_resource_group" "k8s" {
  name     = "${var.prefix}-aks-${var.region}-${var.environment}-${var.location_key}-group"
  location = "${var.location}"
}

module "k8s_cluster" {
  source                        = "./aks"
  AZURE_CLIENT_ID               = var.AZURE_CLIENT_ID
  AZURE_CLIENT_SECRET           = var.AZURE_CLIENT_SECRET
  PUBLIC_SSH_KEY_PATH           = var.PUBLIC_SSH_KEY_PATH
  AZURE_AKS_ADMIN_USER          = var.AZURE_AKS_ADMIN_USER
  environment                   = var.environment
  region                        = var.region
  location_key                  = var.location_key
  location                      = var.location
  vm_size                       = var.vm_size
  vm_count                      = var.vm_count
  kubernetes_version            = var.kubernetes_version
  vnet_subnet_id                = azurerm_subnet.k8s.id
  resource_group                = azurerm_resource_group.k8s.name
  AZURE_AKS_AAD_CLIENT_APP_ID   = var.AZURE_AKS_AAD_CLIENT_APP_ID
  AZURE_AKS_AAD_SERVER_APP_ID   = var.AZURE_AKS_AAD_SERVER_APP_ID
  AZURE_AKS_AAD_SERVER_SECRET   = var.AZURE_AKS_AAD_SERVER_SECRET
  AZURE_TENANT_ID               = var.AZURE_TENANT_ID
}