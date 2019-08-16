variable "AZURE_SUBSCRIPTION_ID" {}

variable "AZURE_TENANT_ID" {}

variable "AZURE_CLIENT_ID" {}

variable "AZURE_CLIENT_SECRET" {}

variable "AZURE_AKS_ADMIN_USER" {}

variable "AZURE_AKS_AAD_CLIENT_APP_ID" {}

variable "AZURE_AKS_AAD_SERVER_APP_ID" {}

variable "AZURE_AKS_AAD_SERVER_SECRET" {}

variable "PUBLIC_SSH_KEY" {}

variable "kubernetes_version" {
  default = "1.13.9"
}

variable "azure_environment" {
  default = "public"
}

variable "environment"{
    default = "dev"
}

variable "region" {
  default = "atfan"
}

variable "prefix" {
  description = "This prefix will be included in the name of some resources."
  default     = "mbdemo2"
}

variable "location" {
  description = "The region where the virtual network is created."
  default     = "eastus"
}

variable "location_key" {
  description = "The region where the virtual network is created."
  default     = "eus"
}

variable "vm_size" {
  default = "Standard_DS2_v2"
}

variable "vm_count" {
  default = "3"
}