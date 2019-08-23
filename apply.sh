#!/usr/bin/env bash

#
# this script is used for creating the execution plan for 
# cluster infrastructure
#
# Base Workspace
echo "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"
whoami
echo "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"
terraform workspace new base setup
terraform workspace select base setup

terraform init -backend-config=/data/backend.tfvars base

terraform apply -input=false -auto-approve base