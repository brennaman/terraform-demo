
def secrets = [
        [$class: 'VaultSecret', path: 'myapp/anothersecret', engineVersion: 2,  secretValues: [
            [$class: 'VaultSecretValue', envVar: 'SECRET_1', vaultKey: 'value']]]
    ]

pipeline {
    agent any

    stages {
        stage('test_vault_access') {
            steps {
                wrap([$class: 'VaultBuildWrapper', vaultSecrets: secrets]) {
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