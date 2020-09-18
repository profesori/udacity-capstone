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
                  sh 'tidy -q -e app/*.html'
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
        stage('Deploying') {
              steps{
                  echo 'Deploying to AWS'
                  withAWS(credentials: 'aws', region: 'us-west-2') {
                      sh "aws eks --region us-west-2 update-kubeconfig --name EksCluster"
                      sh "kubectl config use-context arn:aws:eks:us-west-2:243572158472:cluster/EksCluster"
                      sh "kubectl set image deployments/capstone-project-app capstone-project-app=thoma/capstone-project-app:latest"
                      sh "kubectl apply -f deploy.yml"
                      sh "kubectl get nodes"
                      sh "kubectl get deployment"
                      sh "kubectl get pod -o wide"
                      sh "kubectl get service/capstone-project-app"
                  }
              }
        }
     }
}
