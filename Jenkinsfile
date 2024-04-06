pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = 'ap-southeast-1'
    }
    stages {
        stage('Checkout SCM') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/novandrautomo17/jenkins-terraform-eks-nginx.git']])
            }
        }
        stage('Initializing Terraform') {
            steps {
                script {
                    dir('EKS') {
                        sh 'terraform init'
                    }
                }
            }
        }
        stage('Formatting Terraform') {
            steps {
                script {
                    dir('EKS') {
                        sh 'terraform fmt'
                    }
                }
            }
        }
        stage('Validating Terraform') {
            steps {
                script {
                    dir('EKS') {
                        sh 'terraform validate'
                    }
                }
            }
        }
        stage('Previewing the Infra using Terraform') {
            steps {
                script {
                    dir('EKS') {
                        sh 'terraform plan'
                        input(message: "Are you sure to proceed?", ok: "Proceed")
                    }
                }
            }
        }
        stage('Creating/Destroying an EKS Cluster') {
            steps {
                script {
                    dir('EKS') {
                        sh 'terraform apply --auto-approve'
                    }
                }
            }
        }
        stage('Deploying Nginx Application') {
            steps {
                script {
                    dir('EKS/ConfigurationFiles') {
                        sh 'aws eks update-kubeconfig --name eks-cluster'
                        sh 'kubectl apply -f deployment.yaml'
                        sh 'kubectl apply -f service.yaml'
                    }
                }
            }
        }
    }
}
