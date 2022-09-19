pipeline {
    agent {
        node {
            label 'built-in'
            customWorkspace '/mnt/jenkins'
        }
    }
	stages {
             stage('scm checkout') {
                  steps {
                       git 'https://github.com/aratiparshette/webapp.git'
             }
        }
        stage('build') {
             steps {
                  sh "mvn clean package"	
                  }
        }
        stage('build-image') {
            steps {
                 sh 'service docker start'
                 sh 'docker build -t aratidocker331/mytomcat:1.0.0 .
            }
        } 
        stage('run-container') {
            steps {
                sh 'docker run -d -p 9191:8080 --name webapp aratidocker331/mytomcat:1.0.0'

            }                            
        }
    }
}
