#!/usr/bin/env bash

#
# this script is used for bootstraping the project base infrastructure
#

# Base Workspace
terraform workspace new base setup
terraform workspace select base setup

# create base infra
terraform init -input=false setup
terraform apply -auto-approve -var-file=backend.tfvars setup

# migrate local state to the remote [s3, consul, azure storage account, etc.]
echo "yes" | terraform init -backend-config=backend.tfvars base