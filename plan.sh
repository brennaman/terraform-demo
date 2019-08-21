#!/usr/bin/env bash

#
# this script is used for creating the execution plan for 
# cluster infrastructure
#
terraform init -backend-config=backend.tfvars base

terraform plan -out=tfplan -input=false base