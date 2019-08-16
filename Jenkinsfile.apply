pipeline {
  environment {
    registry = "brennaman3/terraform-rollout-plan"
    registryCredential = 'dockerhub'
    dockerImage = ''
    TERRAFORM_CMD = 'docker run -w /app'
  }
  agent any
  stages {
    stage("Docker Pull") {
      steps{
        sh "docker pull $DOCKER_TRIGGER_REPO_NAME"
      }
    }
    stage("Terraform Apply") {
      steps{
        sh "${TERRAFORM_CMD} -e \"TF_VAR_PUBLIC_SSH_KEY=${env.PUBLIC_SSH_KEY}\" -e \"TF_VAR_AZURE_AKS_ADMIN_USER=${env.AZURE_AKS_ADMIN_USER}\" -e \"TF_VAR_AZURE_AKS_AAD_SERVER_SECRET=${env.AZURE_AKS_AAD_SERVER_SECRET}\" -e \"TF_VAR_AZURE_AKS_AAD_SERVER_APP_ID=${env.AZURE_AKS_AAD_SERVER_APP_ID}\" -e \"TF_VAR_AZURE_AKS_AAD_CLIENT_APP_ID=${env.AZURE_AKS_AAD_CLIENT_APP_ID}\" -e \"TF_VAR_AZURE_SUBSCRIPTION_ID=${env.AZURE_SUBSCRIPTION_ID}\" -e \"TF_VAR_AZURE_TENANT_ID=${env.AZURE_TENANT_ID}\" -e \"TF_VAR_AZURE_CLIENT_ID=${env.AZURE_CLIENT_ID}\" -e \"TF_VAR_AZURE_CLIENT_SECRET=${env.AZURE_CLIENT_SECRET}\" $DOCKER_TRIGGER_REPO_NAME apply -auto-approve"
      }
    }
    stage('Cleanup') {
      steps{
        sh "docker rmi $registry:latest"
        sh "rm -rf *"
      }
    }

    
  }
}