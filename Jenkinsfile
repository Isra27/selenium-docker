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
               bat 'docker build -t=israautomationDevOps/selenium-aut-1 .'
            }
        }

        stage('Push Image'){
           // environment{
                // assuming you have stored the credentials with this name
               // DOCKER_HUB = credentials('dockerhub-creds')
            //}
            steps{
                // There might be a warning.
                //sh 'docker login -u ${DOCKER_HUB_USR} -p ${DOCKER_HUB_PSW}'
                bat 'docker push israautomationDevOps/selenium-aut-1'
            }
        }

    }

  //  post {
    //    always {
      //      sh 'docker logout'
      //  }
    //}

}
