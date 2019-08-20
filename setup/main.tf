provider "azurerm" {
  subscription_id               = "${var.AZURE_SUBSCRIPTION_ID}"
  tenant_id                     = "${var.AZURE_TENANT_ID}"
  client_id                     = "${var.AZURE_CLIENT_ID}"
  client_secret                 = "${var.AZURE_CLIENT_SECRET}"
}

module "backend" {
  source        = "../modules/backend"

  prefix                            = "${var.prefix}"
  environment                        = "${var.environment}"
  location                          = "${var.location}"
}