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
    TERRAFORM_BACKEND_RESOURCE_GRP_NAME = credentials('TERRAFORM_BACKEND_RESOURCE_GRP_NAME')
    TERRAFORM_BACKEND_STORAGE_ACCT_NAME = credentials('TERRAFORM_BACKEND_STORAGE_ACCT_NAME')
    TERRAFORM_BACKEND_CONTAINER_NAME = credentials('TERRAFORM_BACKEND_CONTAINER_NAME')
    TERRAFORM_BACKEND_KEY = credentials('TERRAFORM_BACKEND_KEY')
  }
  agent any
  options { skipDefaultCheckout() }
  stages {
    stage("Docker Pull") {
      steps{
        sh "docker pull $DOCKER_TRIGGER_REPO_NAME"
      }
    }
    stage("Checkout SCM") {
      steps{
        cleanWs()
        //checkout scm
      }
    }
    stage("Terraform Init") {
      steps{
        withCredentials([file(credentialsId: 'AZURERM_BACKEND_CONFIG', variable: 'AZURERM_BACKEND_CONFIG')]) {
          sh "cp $AZURERM_BACKEND_CONFIG backend.tfvars"
          sh '''
            docker run -w /app -v \$(pwd):/data \
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
            $DOCKER_TRIGGER_REPO_NAME $DOCKER_TRIGGER_REPO_NAME init -backend-config=/data/backend.tfvars base && apply -auto-approve base
            '''
        }
      }
    }
    // stage("Terraform Apply") {
    //   steps{
    //     sh '''
    //       docker run -w /app \
    //       -e "TF_VAR_PUBLIC_SSH_KEY=$TF_VAR_PUBLIC_SSH_KEY" \
    //       -e "TF_VAR_AZURE_AKS_ADMIN_USER=$TF_VAR_AZURE_AKS_ADMIN_USER" \
    //       -e "TF_VAR_AZURE_AKS_AAD_SERVER_SECRET=$TF_VAR_AZURE_AKS_AAD_SERVER_SECRET" \
    //       -e "TF_VAR_AZURE_AKS_AAD_SERVER_APP_ID=$TF_VAR_AZURE_AKS_AAD_SERVER_APP_ID" \
    //       -e "TF_VAR_AZURE_AKS_AAD_CLIENT_APP_ID=$TF_VAR_AZURE_AKS_AAD_CLIENT_APP_ID" \
    //       -e "TF_VAR_AZURE_SUBSCRIPTION_ID=$TF_VAR_AZURE_SUBSCRIPTION_ID" \
    //       -e "TF_VAR_AZURE_TENANT_ID=$TF_VAR_AZURE_TENANT_ID" \
    //       -e "TF_VAR_AZURE_CLIENT_ID=$TF_VAR_AZURE_CLIENT_ID" \
    //       -e "TF_VAR_AZURE_CLIENT_SECRET=$TF_VAR_AZURE_CLIENT_SECRET" \
    //       -e "ARM_SUBSCRIPTION_ID=$TF_VAR_AZURE_SUBSCRIPTION_ID" \
    //       -e "ARM_TENANT_ID=$TF_VAR_AZURE_TENANT_ID" \
    //       -e "ARM_CLIENT_ID=$TF_VAR_AZURE_CLIENT_ID" \
    //       -e "ARM_CLIENT_SECRET=$TF_VAR_AZURE_CLIENT_SECRET" \
    //       $DOCKER_TRIGGER_REPO_NAME init -backend-config=~/data/backend.tfvars base && apply -auto-approve base
    //       '''
    //   }
    // }
    // stage('Cleanup') {
    //   steps{
    //     sh "rm -rf *"
    //   }
    // }

    
  }
}