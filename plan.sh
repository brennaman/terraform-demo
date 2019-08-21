#!/usr/bin/env bash

#
# this script is used for creating the execution plan for 
# cluster infrastructure
#
terraform plan -out=tfplan -input=false base