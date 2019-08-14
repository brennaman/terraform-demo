
/*def secrets = [
        [$class: 'VaultSecret', path: 'secrets/azuretest1', secretValues: [
            [$class: 'VaultSecretValue', envVar: 'SUBSCRIPTION_ID', vaultKey: 'value']]]
    ]

def configuration = [$class: 'VaultConfiguration',
                         vaultUrl: 'http://pbjenk01.eastus.azurecontainer.io:8200',
                         vaultCredentialId: 'vault-app-role20']*/


pipeline {
    agent any

    environment {
        SECRET = vault path: 'secrets/azuretest1', key: 'value', vaultUrl: 'http://pbjenk01.eastus.azurecontainer.io:8200', credentialsId: 'vault-app-role20'
    }

    stages {
        stage('test_vault_access') {
            steps {
                echo "${SECRET}"
                /*wrap([$class: 'VaultBuildWrapper', configuration: configuration, vaultSecrets: secrets]) {
                    sh 'echo $SUBSCRIPTION_ID'}*/
                }
            }
        
        stage('test') {
            steps {
                echo 'Testing..'
            }
        }
    }
}