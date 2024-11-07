pipeline {
    agent {
         docker {
            image 'node:16'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
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
