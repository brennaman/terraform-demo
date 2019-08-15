
/*def secrets = [
        [$class: 'VaultSecret', path: 'secret/data/hello', secretValues: [
            [$class: 'VaultSecretValue', envVar: 'SUBSCRIPTION_ID', vaultKey: 'value']]]
    ]

def configuration = [$class: 'VaultConfiguration',
                         vaultUrl: 'http://pbjenk01.eastus.azurecontainer.io:8200',
                         vaultCredentialId: 'vault-token-id']
*/

pipeline {
  environment {
    registry = "brennaman3/terraform-rollout-plan"
    registryCredential = 'dockerhub'
    dockerImage = ''
    // TERRAFORM_CMD = 'docker run hashicorp/terraform:light
    //     -e TF_VAR_AZURE_SUBSCRIPTION_ID = ${env.AZURE_SUBSCRIPTION_ID}
    //     -e TF_VAR_AZURE_TENANT_ID = ${env.AZURE_TENANT_ID}
    //     -e TF_VAR_AZURE_CLIENT_ID = ${env.AZURE_CLIENT_ID}
    //     -e TF_VAR_AZURE_CLIENT_SECRET_ID = ${env.AZURE_CLIENT_SECRET_ID}
    //     -w /app -v $(pwd):/app'

    TERRAFORM_CMD = 'docker run hashicorp/terraform:light -w /app -v $(pwd):/app'
  }
  agent any
  stages {
    stage("Env") {
      steps{
        echo env.AZURE_SUBSCRIPTION_ID
      }
    }
    stage("SH Env") {
      steps{
        sh "echo ${env.AZURE_SUBSCRIPTION_ID}"
      }
    }
    stage("Docker Pull") {
      steps{
        sh "docker pull hashicorp/terraform:light"
      }
    }
    stage("Terraform Init") {
      steps{
        sh "${TERRAFORM_CMD} -e \"TF_VAR_AZURE_SUBSCRIPTION_ID=${env.AZURE_SUBSCRIPTION_ID}\" -e \"TF_VAR_AZURE_TENANT_ID=${env.AZURE_TENANT_ID}\" -e \"TF_VAR_AZURE_CLIENT_ID=${env.AZURE_CLIENT_ID}\" -e \"TF_VAR_AZURE_CLIENT_SECRET_ID=${env.AZURE_CLIENT_SECRET_ID}\" init -backend=true -input=false"
      }
    }
    stage("Terraform Plan") {
      steps{
        sh "${TERRAFORM_CMD} -e \"TF_VAR_AZURE_SUBSCRIPTION_ID=${env.AZURE_SUBSCRIPTION_ID}\" -e \"TF_VAR_AZURE_TENANT_ID=${env.AZURE_TENANT_ID}\" -e \"TF_VAR_AZURE_CLIENT_ID=${env.AZURE_CLIENT_ID}\" -e \"TF_VAR_AZURE_CLIENT_SECRET_ID=${env.AZURE_CLIENT_SECRET_ID}\" plan"
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
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }
    stage("Terraform Init") {
      steps{
        sh "docker run -it $registry:$BUILD_NUMBER -w /app -e \"TF_VAR_AZURE_SUBSCRIPTION_ID=${env.AZURE_SUBSCRIPTION_ID}\" -e \"TF_VAR_AZURE_TENANT_ID=${env.AZURE_TENANT_ID}\" -e \"TF_VAR_AZURE_CLIENT_ID=${env.AZURE_CLIENT_ID}\" -e \"TF_VAR_AZURE_CLIENT_SECRET_ID=${env.AZURE_CLIENT_SECRET_ID}\" init"
      }
    }
    stage("ls") {
      steps{
        sh "ls -a"
      }
    }
    /*
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER" 
        }
      }
    }
    stage('Deploy Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }
    */
  }
}
/*
pipeline {
    agent any

    environment {
        SECRET = vault path: 'secret/data/hello', key: 'value', vaultUrl: 'http://pbjenk01.eastus.azurecontainer.io:8200', credentialsId: 'vault-token-id'
    }

    stages {
        stage('Docker login') {
            steps {
                sh "docker login -u ${env.DOCKER_USERNAME} -p ${env.DOCKER_PASSWORD}"
            }
        }
        stage('test_vault_access') {
            steps {
                //echo "${SECRET}"
                wrap([$class: 'VaultBuildWrapper', configuration: configuration, vaultSecrets: secrets]) {
                    sh 'echo $SUBSCRIPTION_ID'}

                    script{
                        def tfHome = tool name: "Terraform 0.12.6"
                        env.PATH = "${tfHome}:${env.PATH}"
                    }
                    sh "/var/jenkins_home/tools/org.jenkinsci.plugins.terraform.TerraformInstallation/Terraform_0.12.6/terraform"
                    sh "ls -a"
                    //sh "terraform --version"
                }
                
            }
        
        stage('test') {
            steps {
                echo 'Testing..'
            }
        }
    }
}
*/