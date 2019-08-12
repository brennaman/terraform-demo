pipeline {
    agent any

    stages {
        stage('install_deps') {
            steps {
                sh "ls -a"
                /* sh "sudo apt install wget zip python-pip -y"
                sh "cd /tmp"
                sh "curl -o terraform.zip https://releases.hashicorp.com/terraform/'$terraform_version'/terraform_'$terraform_version'_linux_amd64.zip"
                sh "unzip terraform.zip"
                sh "sudo mv terraform /usr/bin"
                sh "rm -rf terraform.zip"*/
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