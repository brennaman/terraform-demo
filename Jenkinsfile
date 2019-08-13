def secrets = [
        [$class: 'VaultSecret', path: 'secret/myapp', secretValues: [
            [$class: 'VaultSecretValue', envVar: 'SECRET_1', vaultKey: 'anothersecret'],
            [$class: 'VaultSecretValue', envVar: 'API_KEY', vaultKey: 'apikey']]]
    ]

pipeline {
    agent any

    stages {
        stage('install_deps') {
            steps {
                wrap([$class: 'VaultBuildWrapper', configuration: configuration, vaultSecrets: secrets]) {
                    sh 'echo $SECRET_1'
                    sh 'echo $tesAPI_KEYting_again'
                }
            }
        }
        stage('init_and_plan') {
            steps {
                sh "echo 'init_and_plandsafsad...'"
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}