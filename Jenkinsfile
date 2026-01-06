pipeline {
    agent any

    options {
        timestamps()
    }

    stages {

        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Network Pre-Check (Jenkins Server)') {
            steps {
                sh '''
                set -e
                echo "Running network check on Jenkins server..."
                chmod +x scripts/network_health_check.sh
                ./scripts/network_health_check.sh
                '''
            }
        }

        stage('Network Check on DEV Server') {
   	     steps {
       		 sh '''
       		 set -e
       		 DEV_HOST="3dexp-dev.example.com"
       		 DEV_USER="devops"
       		 REMOTE_SCRIPT="/tmp/network_health_check.sh"

       		 echo "Copying script to DEV server..."
       		 scp -o StrictHostKeyChecking=no \
           	 scripts/network_health_check.sh \
           	 ${DEV_USER}@${DEV_HOST}:${REMOTE_SCRIPT}

       		 echo "Executing script on DEV server..."
       		 ssh -o StrictHostKeyChecking=no \
           	 ${DEV_USER}@${DEV_HOST} \
           	 "chmod +x ${REMOTE_SCRIPT} && ${REMOTE_SCRIPT}"
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
                echo "Deploy stage started"
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully"
        }
        failure {
            echo "Pipeline failed. Check network or deployment steps"
        }
    }
}
