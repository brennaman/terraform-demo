def secrets = [
        [$class: 'VaultSecret', path: 'secret/myapp', secretValues: [
            [$class: 'VaultSecretValue', envVar: 'SECRET_1', vaultKey: 'anothersecret'],
            [$class: 'VaultSecretValue', envVar: 'API_KEY', vaultKey: 'apikey']]]
    ]

pipeline {
    agent any

    stages {
        stage('test_vault_access') {
            steps {
                wrap([$class: 'VaultBuildWrapper', vaultSecrets: secrets]) {
                    sh 'echo $SECRET_1'
                    sh 'echo $tesAPI_KEYting_again'
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