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
    stage("Checkout SCM") {
      steps{
        sh "deleteDir()"
        sh "checkout scm"
      }
    }
    stage("Docker Pull") {
      steps{
        sh "docker pull brennaman3/terraform-azurecli:light"
      }
    }
    stage("Terraform Init") {
      steps{
        // sh "docker run -w /data -v \$(pwd):/data brennaman3/terraform-azurecli:light workspace new base"
        // sh "docker run -w /data -v \$(pwd):/data brennaman3/terraform-azurecli:light workspace select base"
        
        withCredentials([file(credentialsId: 'AZURERM_BACKEND_CONFIG', variable: 'AZURERM_BACKEND_CONFIG')]) {
          sh "sudo cp $AZURERM_BACKEND_CONFIG backend.tfvars"
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
            -backend-config=backend.tfvars base
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
          brennaman3/terraform-azurecli:light plan base
          '''
      }
    }
    // stage("Docker Build") {
    //   steps{
    //     script {
    //       dockerImage = docker.build registry + ":$BUILD_NUMBER"
    //       dockerLatest = docker.build registry + ":latest"
          
    //     }
    //   }
    // }
    // stage("Docker Push") {
    //   steps{
    //     script {
    //         docker.withRegistry( '', registryCredential ) {
    //             dockerImage.push()
    //             dockerLatest.push()
    //         }

    //     }
    //   }
    // }
    // stage('Cleanup') {
    //   steps{
    //     sh "rm -rf *"
    //     sh "rm -rf .*"
    //   }
    // }
  }
}