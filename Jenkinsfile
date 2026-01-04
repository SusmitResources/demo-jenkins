pipeline {
    agent any

    stages {

        stage('Checkout SCM') {
            steps {
                checkout scm
                sh '''
                  echo "Workspace path:"
                  pwd
                  echo "Files in workspace:"
                  ls -la
                '''
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
