resource "azurerm_resource_group" "k8s_rg" {
  name     = "${var.environment}_${var.region}_${var.location_key}_k8s_rg"
  location = "${var.location}"
}