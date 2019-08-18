pipeline {
  environment {
    registry = "brennaman3/terraform-rollout-plan"
    registryCredential = 'dockerhub'
    dockerImage = ''
    dockerLatest = ''
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
  stages {
    stage("Docker Pull") {
      steps{
        sh "docker pull brennaman3/terraform-azurecli:light"
      }
    }
    stage("Terraform Init") {
      steps{
        // sh '''
        //   docker run -w /data -v \$(pwd):/data \
        //   -e "TF_VAR_PUBLIC_SSH_KEY=$TF_VAR_PUBLIC_SSH_KEY" \
        //   -e "TF_VAR_AZURE_AKS_ADMIN_USER=$TF_VAR_AZURE_AKS_ADMIN_USER" \
        //   -e "TF_VAR_AZURE_AKS_AAD_SERVER_SECRET=$TF_VAR_AZURE_AKS_AAD_SERVER_SECRET" \
        //   -e "TF_VAR_AZURE_AKS_AAD_SERVER_APP_ID=$TF_VAR_AZURE_AKS_AAD_SERVER_APP_ID" \
        //   -e "TF_VAR_AZURE_AKS_AAD_CLIENT_APP_ID=$TF_VAR_AZURE_AKS_AAD_CLIENT_APP_ID" \
        //   -e "TF_VAR_AZURE_SUBSCRIPTION_ID=$TF_VAR_AZURE_SUBSCRIPTION_ID" \
        //   -e "TF_VAR_AZURE_TENANT_ID=$TF_VAR_AZURE_TENANT_ID" \
        //   -e "TF_VAR_AZURE_CLIENT_ID=$TF_VAR_AZURE_CLIENT_ID" \
        //   -e "TF_VAR_AZURE_CLIENT_SECRET=$TF_VAR_AZURE_CLIENT_SECRET" \
        //   -e "ARM_SUBSCRIPTION_ID=$TF_VAR_AZURE_SUBSCRIPTION_ID" \
        //   -e "ARM_TENANT_ID=$TF_VAR_AZURE_TENANT_ID" \
        //   -e "ARM_CLIENT_ID=$TF_VAR_AZURE_CLIENT_ID" \
        //   -e "ARM_CLIENT_SECRET=$TF_VAR_AZURE_CLIENT_SECRET" \
        //   brennaman3/terraform-azurecli:light init \
        //   -backend-config="resource_group_name=$TERRAFORM_BACKEND_RESOURCE_GRP_NAME" \
        //   -backend-config="storage_account_name=$TERRAFORM_BACKEND_STORAGE_ACCT_NAME" \
        //   -backend-config="container_name=$TERRAFORM_BACKEND_CONTAINER_NAME" \
        //   -backend-config="key=$TERRAFORM_BACKEND_KEY"
        //   '''
        withCredentials([file(credentialsId: 'AZURERM_BACKEND_CONFIG', variable: 'AZURERM_BACKEND_CONFIG')]) {
          sh "echo ${AZURERM_BACKEND_CONFIG} > azurerm-backend.config"
          sh '''
            docker run -w /data -v \$(pwd):/data \
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
            brennaman3/terraform-azurecli:light init \
            -backend-config="resource_group_name=azurerm-backend.config"
            '''
        }
        
      }
    }
    stage("Terraform Plan") {
      steps{
        sh '''
          docker run -w /data -v \$(pwd):/data \
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
          brennaman3/terraform-azurecli:light plan
          '''
      }
    }
    stage("Docker Build") {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
          dockerLatest = docker.build registry + ":latest"
          
        }
      }
    }
    stage("Docker Push") {
      steps{
        script {
            docker.withRegistry( '', registryCredential ) {
                dockerImage.push()
                dockerLatest.push()
            }

        }
      }
    }
    // stage('Cleanup') {
    //   steps{
    //     sh "rm -rf *"
    //   }
    // }
  }
}