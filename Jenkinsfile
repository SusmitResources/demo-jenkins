pipeline {
    agent any

    environment {
        DEV_HOST = "3dexp-dev.example.com"
        QA_HOST  = "3dexp-qa.example.com"
        PROD_HOST= "3dexp-prod.example.com"
    }

    stages {

        stage('Checkout') {
            steps {
                git 'git@github.com:SusmitResources/demo-jenkins.git'
            }
        }

        stage('Build') {
            steps {
                sh 'ant clean build'
            }
        }

        stage('Deploy to DEV') {
            steps {
                sh './demo_deploy.sh dev'
            }
        }

        stage('Approval for QA') {
            steps {
                input message: 'Deploy to QA?'
            }
        }

        stage('Deploy to QA') {
            steps {
                sh './demo_deploy.sh qa'
            }
        }

        stage('Approval for PROD') {
            steps {
                input message: 'Deploy to PROD?'
            }
        }

        stage('Deploy to PROD') {
            steps {
                sh './demo_deploy.sh prod'
            }
        }
    }
}
