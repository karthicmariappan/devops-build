pipeline {
    agent any

    environment {
        DOCKER_USER = "karthickm13799"   // your Docker Hub username
        APP_NAME = "dev"
    }

    triggers {
        githubPush()   // auto trigger on push
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    if (env.BRANCH_NAME == "dev") {
                        IMAGE = "${DOCKER_USER}/dev:${env.BUILD_NUMBER}"
                        LATEST = "${DOCKER_USER}/dev:latest"
                    } else if (env.BRANCH_NAME == "master") {
                        IMAGE = "${DOCKER_USER}/prod:${env.BUILD_NUMBER}"
                        LATEST = "${DOCKER_USER}/prod:latest"
                    }
                }
                sh """
                    docker build -t $IMAGE -t $LATEST .
                """
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds',
                                                 usernameVariable: 'USERNAME',
                                                 passwordVariable: 'PASSWORD')]) {
                    sh """
                        echo "$PASSWORD" | docker login -u "$USERNAME" --password-stdin
                        docker push $IMAGE
                        docker push $LATEST
                    """
                }
            }
        }
    }
}
