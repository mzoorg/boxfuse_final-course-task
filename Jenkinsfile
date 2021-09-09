def SSH_PRV
def SSH_PUB
def DOCKERHUB_TOKEN

node {
  SSH_PRV = sh(returnStdout: true, script: 'cat /var/lib/jenkins/.ssh/id_rsa')
  SSH_PUB = sh(returnStdout: true, script: 'cat /var/lib/jenkins/.ssh/id_rsa.pub')
  DOCKERHUB_TOKEN = ''
}

pipeline {
    agent any
    
    tools {
        terraform 'terraform105'
    }

    stages {
        stage('Git clone') {
            steps {
                git branch: 'main', url: 'https://github.com/mzoorg/final_project_devops.git'
            }
        }
        stage('Terraform init') {
            steps {
                sh '''terraform init'''
            }
        }
        stage('Terraform apply') {
            steps {
                sh "terraform apply -auto-approve -var='my_private_key=${SSH_PRV}' -var='my_public_key=${SSH_PUB}' -var='my_dockerhub_pass=${DOCKERHUB_TOKEN}'"
            }
        }
    }
}
