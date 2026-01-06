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

        stage('Network Check on DEV (Ansible)') {
 	   steps {
        	sh '''
        	set -e
        	echo "Running network check on DEV using Ansible..."
        	ansible-playbook \
          	-i ansible/inventory \
          	ansible/network_check.yml
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

