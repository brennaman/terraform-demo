#!/usr/bin/env bash

#
# this script is used for creating the execution plan for 
# cluster infrastructure
#
# Base Workspace
sudo terraform workspace new base setup
sudo terraform workspace select base setup

sudo terraform init -backend-config=/data/backend.tfvars base

sudo terraform apply -input=false -auto-approve base