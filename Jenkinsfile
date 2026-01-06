pipeline {
    agent any

    stages {

        stage('Network Pre-Check') {
            steps {
                sh '''
                chmod +x scripts/network_health_check.sh
                scripts/network_health_check.sh
                '''
            }
        }

        stage('Build') {
            steps {
                echo "Build stage started"
            }
        }

        stage('Deploy') {
            steps {
                echo "Deploying application"
            }
        }
    }

    post {
        failure {
            echo "Pipeline failed due to network or build issue"
        }
        success {
            echo "Pipeline completed successfully"
        }
    }
}
