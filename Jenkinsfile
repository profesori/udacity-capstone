pipeline {
     agent any
     stages {
         stage('Build') {
             steps {
                 sh 'echo "Hello World from rudi"'
             }
         }
         stage('Lint HTML') {
              steps {
                  sh 'tidy -q -e *.html'
              }
         }
         stage('Security Scan') {
              steps { 
                 aquaMicroscanner imageName: 'alpine:latest', notCompleted: 'exit 1', onDisallowed: 'fail'
              }
         }
        stage('Build Docker Image') {
              steps {
                  sh 'docker build --tag=capstone-project-app .'
              }
         }
        stage('Push Docker Image') {
              steps {
                  withDockerRegistry([url: "", credentialsId: "dockerhub"]) {
                      sh "docker tag capstone-project-app thoma/capstone-project-app"
                      sh 'docker push thoma/capstone-project-app'
                  }
              }
         }
        stage('Deploy') {
              steps{
                  echo 'Deploying to AWS with Kubernetes'
                  withAWS(credentials: 'aws-rudi', region: 'us-west-2') {
                      sh "aws eks --region us-west-2 update-kubeconfig --name EksCluster"
                      sh "kubectl config use-context arn:aws:eks:us-west-2:243572158472:cluster/EksCluster"
                      sh "kubectl apply -f deploy-k8.yaml"
                  }
              }
        }
     }
}
