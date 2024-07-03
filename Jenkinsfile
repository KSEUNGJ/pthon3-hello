pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = 'dockerhub-credentials' // Jenkins 자격 증명 ID
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from Git using the specified credentials
                git url: 'https://github.com/KSEUNGJ/python3-hello.git', branch: 'main', credentialsId: 'gitID-PW'
            }
        }
        stage('Build Docker Image') {
            steps {
                // Docker 이미지를 빌드
                sh 'docker build -t yoyoyellow/hello.py .'
            }
        }
        stage('Login to Docker Hub') {
            steps {
                // withCredentials 블록을 사용하여 Docker Hub 자격 증명을 로드
                withCredentials([usernamePassword(credentialsId: "${DOCKERHUB_CREDENTIALS}", usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                    script {
                        // Docker Hub에 로그인
                        sh 'echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_USERNAME --password-stdin'
                    }
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                // Docker 이미지를 Docker Hub에 푸시
                sh 'docker push yoyoyellow/hello.py'
            }
        }
    }
    
    post {
        always {
            // 빌드 후 항상 실행되는 단계
            echo 'Cleaning up...'
            // 필요시 추가 정리 작업 수행
        }
        success {
            // 빌드가 성공했을 때 실행되는 단계
            echo 'Build and push successful!'
        }
        failure {
            // 빌드가 실패했을 때 실행되는 단계
            echo 'Build or push failed.'
        }
    }
}
