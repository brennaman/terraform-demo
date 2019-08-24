resource "azurerm_resource_group" "k8s" {
  name     = "${var.prefix}-aks-${var.region}-${var.environment}-${var.location_key}-group"
  location = "${var.location}"
}
resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "${var.prefix}-aks-${var.region}-${var.environment}-${var.location_key}"
  location            = "${var.location}"
  dns_prefix          = "${var.prefix}-aks-${var.region}-${var.environment}-${var.location_key}"
  resource_group_name = "${azurerm_resource_group.k8s.name}"
  kubernetes_version  = "${var.kubernetes_version}"

  linux_profile {
    admin_username = "${var.AZURE_AKS_ADMIN_USER}"

    ssh_key {
      key_data = "${var.PUBLIC_SSH_KEY}"
    }
  }

  agent_pool_profile {
    name            = "agentpool"
    count           = "2"
    vm_size         = "Standard_DS1_v2"
    os_type         = "Linux"
    os_disk_size_gb = 30

    # Required for advanced networking
    vnet_subnet_id = "${var.vnet_subnet_id}"
  }

  service_principal {
    client_id     = "${var.AZURE_CLIENT_ID}"
    client_secret = "${var.AZURE_CLIENT_SECRET}"
  }
    
  network_profile {
    network_plugin = "azure"
  }

  role_based_access_control {
    enabled = true
        azure_active_directory {
            server_app_id     = "${var.AZURE_AKS_AAD_SERVER_APP_ID}"
            server_app_secret = "${var.AZURE_AKS_AAD_SERVER_SECRET}"
            client_app_id     = "${var.AZURE_AKS_AAD_CLIENT_APP_ID}"
            tenant_id         = "${var.AZURE_TENANT_ID}"
        }
  }

  

}
  