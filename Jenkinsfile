pipeline {
    agent any
    
    tools {
        maven 'maven'
    }
    
    environment {
        // Automatically extracts and assigns your keys safely
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCEESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }
    
    stages {
        stage('clean') {
            steps {
              cleanWs()
            }
        }
        stage('checkout') {
            steps {
                git branch: '$branch', credentialsId: 'github', url: 'https://github.com/RAHAMSHAIK007/jenkins-java-project.git'
            }
        }
        stage('build') {
            steps {
                sh 'mvn compile'
            }
        }
        stage('test') {
            steps {
                sh 'mvn test'
            }
        }
        stage('artifact') {
            steps {
                sh 'mvn package'
            }
        }
        stage('s3') {
            steps {
                sh 'aws s3 cp /var/lib/jenkins/workspace/ci-pipeline/target/NETFLIX-1.2.2.war s3://k8s-cluster-backup-008 '
            }
        }
        stage('deploy') {
            steps {
                deploy adapters: [tomcat9(alternativeDeploymentContext: '', credentialsId: 'tomcat', path: '', url: 'http://3.7.70.46:8080/')], contextPath: 'netflix', war: 'target/NETFLIX-1.2.2.war'
            }
        }
    }
}
