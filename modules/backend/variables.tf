variable "prefix" {}
variable "environment" {}
variable "location" {}

#backend config specific to azure
variable "resource_group_name" {
  default="mb1982103-terraform-state-group"
}
variable "storage_account_name" {
  default="mb1982103tfstatesa"
}
variable "container_name" {
  default="mb1982103-tfstate"
}
variable "key" {
  default="terraform.state"
}
variable "replication_type" {
  default="LRS"
}