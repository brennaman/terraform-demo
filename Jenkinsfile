
def secrets = [
        [$class: 'VaultSecret', path: 'secrets/azuretest', engineVersion: 2,  secretValues: [
            [$class: 'VaultSecretValue', envVar: 'SUBSCRIPTION_ID', vaultKey: 'subscriptionid']]]
    ]

pipeline {
    agent any

    stages {
        stage('test_vault_access') {
            steps {
                wrap([$class: 'VaultBuildWrapper', vaultSecrets: secrets]) {
                    sh 'echo $SUBSCRIPTION_ID'
                }
            }
        }
        stage('test') {
            steps {
                echo 'Testing..'
            }
        }
    }
}