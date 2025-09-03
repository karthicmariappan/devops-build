pipeline {
    agent any

    environment {
        DOCKER_USER = "karthickm13799"
        APP_NAME    = "dev"
        TARGET      = "dev"
        VERSION     = "v1"
        REPO        = "${DOCKER_USER}/${TARGET}"
        IMAGE       = "${REPO}:${VERSION}"
        LATEST      = "${REPO}:latest"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/karthicmariappan/devops-build'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE -t $LATEST .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                      echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                      docker push $IMAGE
                      docker push $LATEST
                    '''
                }
            }
        }
    }
}
