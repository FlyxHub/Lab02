pipeline {
    agent {
        label 'AppServer'
    }

    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker image') {
            steps {
                script {
                    app = docker.build('flyxdocker/qr-generator:latest')
                }
            }
        }

        stage('Push image to Dockerhub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-creds') {
                        app.push('latest')
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sh 'docker-compose down'
                    sh 'docker-compose up -d'
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }

        succes {
            echo 'Deployment successful'
        }

        failure {
            echo 'Deployment unsuccessful'
        }
    }
}
