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
     }
}
