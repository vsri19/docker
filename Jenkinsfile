pipeline {
    agent any{

        docker { image 'docker:latest' }
    }

    stages {
        stage('build') {
            steps {
                sh '''docker build -t test .'''
            }
        }
    }
}
