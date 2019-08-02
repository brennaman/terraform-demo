# create resouce group for networking components
resource "azurerm_resource_group" "main_network" {
  name     = "${var.prefix}-${var.resource_group_network}"
  location = "${var.location}"
}

#create vNet
resource "azurerm_virtual_network" "vnet_main" {
  name                = "${var.prefix}-${var.virtual_network_name}"
  location            = "${azurerm_resource_group.main_network.location}"
  address_space       = ["${var.address_space}"]
  resource_group_name = "${azurerm_resource_group.main_network.name}"
}

#create main subnet
resource "azurerm_subnet" "subnet" {
  name                 = "main-subnet"
  virtual_network_name = "${azurerm_virtual_network.vnet_main.name}"
  resource_group_name  = "${azurerm_resource_group.main_network.name}"
  address_prefix       = "${var.subnet_prefix}"
}

# create security group to allow inbound access on port 80 (http) and 3389 (rdp)
resource "azurerm_network_security_group" "main_network-sg" {
  name                = "${var.prefix}-sg"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.main_network.name}"

  security_rule {
    name                       = "HTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "${var.source_network}"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "RDP"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "${var.source_network}"
    destination_address_prefix = "*"
  }
}

# create an Azure Container Registry
resource "azurerm_resource_group" "main_acr_rg" {
  name     = "${var.prefix}-container-reg-group"
  location = "${var.location}"
}

resource "azurerm_container_registry" "acr" {
  name                     = "${var.prefix}-container-reg"
  resource_group_name      = "${azurerm_resource_group.main_acr_rg.name}"
  location                 = "${azurerm_resource_group.main_acr_rg.location}"
  sku                      = "Basic"
  admin_enabled            = false
}