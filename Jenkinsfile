
def secrets = [
        [$class: 'VaultSecret', path: 'secrets/myapp', engineVersion: 2,  secretValues: [
            [$class: 'VaultSecretValue', envVar: 'SECRET_1', vaultKey: 'anothersecret']]]
    ]

 def configuration = [$class: 'VaultConfiguration',
                         vaultUrl: 'http://pbjenk01.eastus.azurecontainer.io:8200',
                         vaultCredentialId: 'pbjenk01']

pipeline {
    agent any

    stages {
        stage('test_vault_access') {
            steps {
                wrap([$class: 'VaultBuildWrapper', configuration: configuration, vaultSecrets: secrets]) {
                    sh 'echo $SECRET_1'
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