#!/usr/bin/env bash

#
# this script is used for bootstraping the project base infrastructure
#

# Base Workspace
terraform workspace new base setup
terraform workspace select base setup

# create base infra
terraform init setup
terraform apply -var-file=backend.tfvars -auto-approve setup

# migrate local state to the remote [s3, consul, azure storage account, etc.]
terraform init -backend-config=backend.tfvars base