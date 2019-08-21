#!/usr/bin/env bash

#
# this script is used for creating the execution plan for 
# cluster infrastructure
#
# Base Workspace
terraform workspace new base setup
terraform workspace select base setup

terraform init -backend-config=backend.tfvars base

terraform apply -input=false base