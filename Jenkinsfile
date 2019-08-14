
def secrets = [
        [$class: 'VaultSecret', path: 'secret/data/hello', secretValues: [
            [$class: 'VaultSecretValue', envVar: 'SUBSCRIPTION_ID', vaultKey: 'value']]]
    ]

def configuration = [$class: 'VaultConfiguration',
                         vaultUrl: 'http://pbjenk01.eastus.azurecontainer.io:8200',
                         vaultCredentialId: 'vault-token-id']


pipeline {
    agent any

    /*environment {
        SECRET = vault path: 'secret/data/hello', key: 'value', vaultUrl: 'http://pbjenk01.eastus.azurecontainer.io:8200', credentialsId: 'vault-token-id'
    }*/

    stages {
        stage('test_vault_access') {
            steps {
                //echo "${SECRET}"
                /*wrap([$class: 'VaultBuildWrapper', configuration: configuration, vaultSecrets: secrets]) {
                    sh 'echo $SUBSCRIPTION_ID'}*/

                    
                    def tfHome = tool name: "Terraform 0.12.6"
                    dev tf = "${tfHome}/terraform"
                    
                    sh "${tf} version"
                }
                
            }
        
        stage('test') {
            steps {
                echo 'Testing..'
            }
        }
    }
}