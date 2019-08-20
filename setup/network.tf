resource "azurerm_resource_group" "k8s_network_group" {
  name     = "${var.prefix}-k8s-network-group"
  location = "${var.location}"
}

resource "azurerm_virtual_network" "k8s_vnet" {
  name                = "${var.prefix}-network"
  location            = "${azurerm_resource_group.k8s_network_group.location}"
  resource_group_name = "${azurerm_resource_group.k8s_network_group.name}"
  address_space       = ["10.101.0.0/16"]
}

resource "azurerm_subnet" "k8s_internal1_subnet" {
  name                 = "internal1"
  resource_group_name  = "${azurerm_resource_group.k8s_network_group.name}"
  address_prefix       = "10.101.0.0/24"
  virtual_network_name = "${azurerm_virtual_network.k8s_vnet.name}"
}

resource "azurerm_subnet" "k8s_internal2_subnet" {
  name                 = "internal2"
  resource_group_name  = "${azurerm_resource_group.k8s_network_group.name}"
  address_prefix       = "10.101.1.0/24"
  virtual_network_name = "${azurerm_virtual_network.k8s_vnet.name}"
}

resource "azurerm_subnet" "k8s_internal3_subnet" {
  name                 = "internal3"
  resource_group_name  = "${azurerm_resource_group.k8s_network_group.name}"
  address_prefix       = "10.101.3.0/24"
  virtual_network_name = "${azurerm_virtual_network.k8s_vnet.name}"
}

resource "azurerm_subnet" "k8s_internal4_subnet" {
  name                 = "internal4"
  resource_group_name  = "${azurerm_resource_group.k8s_network_group.name}"
  address_prefix       = "10.101.4.0/24"
  virtual_network_name = "${azurerm_virtual_network.k8s_vnet.name}"
}
