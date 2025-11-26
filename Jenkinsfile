pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("my-vite-app:latest")
                }
            }
        }

        stage('Run CI Inside Docker') {
            agent {
                docker {
                    image 'my-vite-app:latest'
                }
            }
            steps {
                sh 'npm ci'
                sh 'npm run build'
                sh 'npm test --if-present'
            }
        }

        stage('Archive Build Artifacts') {
            steps {
                archiveArtifacts artifacts: 'dist/**', fingerprint: true
            }
        }
    }
}
