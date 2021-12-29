pipeline {
    agent any
    environment {
        registry = "renatts/mavenexercise"
        registryCredential = "dockerHub_id"
        dockerImage = ''
    }

    stages {
        stage("Tools initialization") {
            steps {
                sh "mvn --version"
                sh "java -version"
            }
        }
        stage('Checkout source code') {
            steps {
                checkout scm
            }
        }
        stage('Build') {
            steps {
                script {
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }
        stage('Publish') {
            steps {
                script {
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push('latest')
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    kubernetesDeploy(configs: "manifests/deployment.yml,manifests/service.yml", kubeconfigId: "kubernetes_id")
                    sh 'kubectl apply -f manifests/ingress.yml'
                }
            }
        }
    }
}
