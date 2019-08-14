provider "azurerm" {
  subscription_id               = "${var.AZURE_SUBSCRIPTION_ID}"
  tenant_id                     = "${var.AZURE_TENANT_ID}"
  client_id                     = "${var.AZURE_CLIENT_ID}"
  client_secret                 = "${var.AZURE_CLIENT_SECRET_ID}"
}

resource "azurerm_resource_group" "k8s_rg" {
  name     = "${var.environment}_${var.region}_${var.location_key}_k8s_rg"
  location = "${var.location}"
}