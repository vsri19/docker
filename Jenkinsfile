pipeline {
    agent {
         docker {
            image 'node:16'
            args '-u root:root'
        }
    }

    stages {
        stage('build') {
            steps {
                sh 'docker build -t test .'
            }
        }
    }
}
