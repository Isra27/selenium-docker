pipeline{

    agent any

    stages{

        stage('Build Jar'){
            steps{
                bat 'mvn clean package -DskipTests'
            }
        }

        stage('Build Image'){
            steps{
               bat 'docker build -t=israautomationdevops/selenium-aut-1 .'
            }
        }

        stage('Push Image'){
            environment{
                // assuming you have stored the credentials with this name
                DOCKER_HUB = credentials('dockerhub-creds')
            }
            steps{
                // There might be a warning.
                //bat 'docker login -u %DOCKER_HUB_USR% -p %DOCKER_HUB_PSW%'
                bat 'echo %DOCKER_HUB_PSW% | docker login -u %DOCKER_HUB_USR% --password-stdin'
                bat 'docker push israautomationdevops/selenium-aut-1'
                //bat "docker tag israautomationdevops/selenium-aut-1:latest israautomationdevops/selenium-aut-1:${env.BUILD_NUMBER}"
                //bat "docker push israautomationdevops/selenium-aut-1:${env.BUILD_NUMBER}"
            }
        }
    }

    post {
        always {
            bat 'docker logout'
        }
    }


}
