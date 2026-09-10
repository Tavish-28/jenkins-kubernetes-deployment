pipeline {
  environment {
   dockerimagename = "tavish27/react-app"
    dockerImage = ""
  }
  agent any
  stages {
    stage('Checkout Source') {
      steps {
        git branch: 'main', url: 'https://github.com/Tavish-28/jenkins-kubernetes-deployment.git'
      }
    }
    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build dockerimagename
        }
      }
    }
    stage('Pushing Image') {
      environment {
          registryCredential = 'dockerhub-credentials'
           }
      steps{
        script {
          docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
            dockerImage.push("latest")
          }
        }
      }
    }
   stage('Deploying React.js container to Kubernetes') {
     steps {
       withCredentials([file(credentialsId: 'kubeconfig-credential', variable: 'KUBECONFIG')]) {
         sh 'kubectl apply -f deployment.yaml'
         sh 'kubectl apply -f service.yaml'
       }
     }
   }
  }
}
