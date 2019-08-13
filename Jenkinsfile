

def secrets = vaultSecrets([
    'secrets/myapp/anothersecret': [var: 'SECRET_1', key: 'value']
])

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