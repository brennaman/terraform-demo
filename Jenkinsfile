
def secrets = [
        [$class: 'VaultSecret', path: 'secrets/azuretest', secretValues: [
            [$class: 'VaultSecretValue', envVar: 'SUBSCRIPTION_ID', vaultKey: 'subscriptionid']]]
    ]

def configuration = [$class: 'VaultConfiguration',
                         vaultUrl: 'http://pbjenk01.eastus.azurecontainer.io:8200',
                         vaultCredentialId: 'vault-app-role11']

pipeline {
    agent any

    stages {
        stage('test_vault_access') {
            steps {
                echo env.azure_subscription_id
                }
            }
        
        stage('test') {
            steps {
                echo 'Testing..'
            }
        }
    }
}