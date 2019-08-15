pipeline {
  environment {
    registry = "brennaman3/terraform-rollout-plan"
    registryCredential = 'dockerhub'
    dockerImage = ''
    TERRAFORM_CMD = 'docker run -w /data -v "$(pwd)":/data'
  }
  agent any
  stages {
    stage("Docker Pull") {
      steps{
        sh "docker pull hashicorp/terraform:light"
      }
    }
    stage("Terraform Init") {
      steps{
        sh "${TERRAFORM_CMD} -e \"TF_VAR_PUBLIC_SSH_KEY=${env.PUBLIC_SSH_KEY}\" -e \"TF_VAR_AZURE_AKS_ADMIN_USER=${env.AZURE_AKS_ADMIN_USER}\" -e \"TF_VAR_AZURE_AKS_AAD_SERVER_SECRET=${env.AZURE_AKS_AAD_SERVER_SECRET}\" -e \"TF_VAR_AZURE_AKS_AAD_SERVER_APP_ID=${env.AZURE_AKS_AAD_SERVER_APP_ID}\" -e \"TF_VAR_AZURE_AKS_AAD_CLIENT_APP_ID=${env.AZURE_AKS_AAD_CLIENT_APP_ID}\" -e \"TF_VAR_AZURE_SUBSCRIPTION_ID=${env.AZURE_SUBSCRIPTION_ID}\" -e \"TF_VAR_AZURE_TENANT_ID=${env.AZURE_TENANT_ID}\" -e \"TF_VAR_AZURE_CLIENT_ID=${env.AZURE_CLIENT_ID}\" -e \"TF_VAR_AZURE_CLIENT_SECRET=${env.AZURE_CLIENT_SECRET}\" hashicorp/terraform:light init"
      }
    }
    stage("Terraform Plan") {
      steps{
        sh "${TERRAFORM_CMD} -e \"TF_VAR_PUBLIC_SSH_KEY=${env.PUBLIC_SSH_KEY}\" -e \"TF_VAR_AZURE_AKS_ADMIN_USER=${env.AZURE_AKS_ADMIN_USER}\" -e \"TF_VAR_AZURE_AKS_AAD_SERVER_SECRET=${env.AZURE_AKS_AAD_SERVER_SECRET}\" -e \"TF_VAR_AZURE_AKS_AAD_SERVER_APP_ID=${env.AZURE_AKS_AAD_SERVER_APP_ID}\" -e \"TF_VAR_AZURE_AKS_AAD_CLIENT_APP_ID=${env.AZURE_AKS_AAD_CLIENT_APP_ID}\" -e \"TF_VAR_AZURE_SUBSCRIPTION_ID=${env.AZURE_SUBSCRIPTION_ID}\" -e \"TF_VAR_AZURE_TENANT_ID=${env.AZURE_TENANT_ID}\" -e \"TF_VAR_AZURE_CLIENT_ID=${env.AZURE_CLIENT_ID}\" -e \"TF_VAR_AZURE_CLIENT_SECRET=${env.AZURE_CLIENT_SECRET}\" hashicorp/terraform:light plan"
      }
    }
    stage("Docker Build") {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage("Docker Push") {
      steps{
        script {
            docker.withRegistry( '', registryCredential ) {
                dockerImage.push()
            }
        }
      }
    }
    stage('Cleanup') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
        sh "rm -rf *"
      }
    }
  }
}