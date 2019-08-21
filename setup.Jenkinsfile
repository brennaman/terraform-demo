pipeline {
  environment {
    TF_VAR_PUBLIC_SSH_KEY = credentials('PUBLIC_SSH_KEY')
    TF_VAR_AZURE_CLIENT_ID = credentials('AZURE_CLIENT_ID')
    TF_VAR_AZURE_CLIENT_SECRET = credentials('AZURE_CLIENT_SECRET')
    TF_VAR_AZURE_AKS_ADMIN_USER = credentials('AZURE_AKS_ADMIN_USER')
    TF_VAR_AZURE_AKS_AAD_SERVER_SECRET = credentials('AZURE_AKS_AAD_SERVER_SECRET')
    TF_VAR_AZURE_AKS_AAD_SERVER_APP_ID = credentials('AZURE_AKS_AAD_SERVER_APP_ID')
    TF_VAR_AZURE_AKS_AAD_CLIENT_APP_ID = credentials('AZURE_AKS_AAD_CLIENT_APP_ID')
    TF_VAR_AZURE_SUBSCRIPTION_ID = credentials('AZURE_SUBSCRIPTION_ID')
    TF_VAR_AZURE_TENANT_ID = credentials('AZURE_TENANT_ID')
  }
  agent any
  options { skipDefaultCheckout() }
  stages {
    stage("Docker Pull") {
      steps{
        sh "docker pull brennaman3/terraform-azurecli:full"
      }
    }
    stage("Checkout SCM") {
      steps{
        cleanWs()
        checkout scm
      }
    }
    stage("Remote Backend Setup")
    {
      steps{
        withCredentials([file(credentialsId: 'AZURERM_BACKEND_CONFIG', variable: 'AZURERM_BACKEND_CONFIG')]) {
          sh "cp $AZURERM_BACKEND_CONFIG backend.tfvars"
          sh '''
            docker run --rm -w /app -v \$(pwd):/app \
            -e "TF_VAR_PUBLIC_SSH_KEY=$TF_VAR_PUBLIC_SSH_KEY" \
            -e "TF_VAR_AZURE_AKS_ADMIN_USER=$TF_VAR_AZURE_AKS_ADMIN_USER" \
            -e "TF_VAR_AZURE_AKS_AAD_SERVER_SECRET=$TF_VAR_AZURE_AKS_AAD_SERVER_SECRET" \
            -e "TF_VAR_AZURE_AKS_AAD_SERVER_APP_ID=$TF_VAR_AZURE_AKS_AAD_SERVER_APP_ID" \
            -e "TF_VAR_AZURE_AKS_AAD_CLIENT_APP_ID=$TF_VAR_AZURE_AKS_AAD_CLIENT_APP_ID" \
            -e "TF_VAR_AZURE_SUBSCRIPTION_ID=$TF_VAR_AZURE_SUBSCRIPTION_ID" \
            -e "TF_VAR_AZURE_TENANT_ID=$TF_VAR_AZURE_TENANT_ID" \
            -e "TF_VAR_AZURE_CLIENT_ID=$TF_VAR_AZURE_CLIENT_ID" \
            -e "TF_VAR_AZURE_CLIENT_SECRET=$TF_VAR_AZURE_CLIENT_SECRET" \
            -e "ARM_SUBSCRIPTION_ID=$TF_VAR_AZURE_SUBSCRIPTION_ID" \
            -e "ARM_TENANT_ID=$TF_VAR_AZURE_TENANT_ID" \
            -e "ARM_CLIENT_ID=$TF_VAR_AZURE_CLIENT_ID" \
            -e "ARM_CLIENT_SECRET=$TF_VAR_AZURE_CLIENT_SECRET" \
            brennaman3/terraform-azurecli:full bash setup.sh
            '''
        }
      }
    }
  }
}