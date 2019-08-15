variable "AZURE_TENANT_ID" {}

variable "AZURE_SUBSCRIPTION_ID" {}

variable "AZURE_CLIENT_ID" {}

variable "AZURE_CLIENT_SECRET" {}

variable "PUBLIC_SSH_KEY_PATH" {}

variable "AZURE_AKS_ADMIN_USER" {}

variable "AZURE_AKS_AAD_CLIENT_APP_ID" {}

variable "AZURE_AKS_AAD_SERVER_APP_ID" {}

variable "AZURE_AKS_AAD_SERVER_SECRET" {}

variable "kubernetes_version" {}

variable "prefix" {
    default = "mbdemo"
}

variable "environment" {
  default = "dev"
}

variable "region" {
  default = "atfan"
}

variable "location_key" {
  default = "eus"
}

variable "location" {
  default = "eastus"
}

variable "vm_size" {
  default = "Standard_DS2_v2"
}

variable "vm_count" {
  default = "3"
}

