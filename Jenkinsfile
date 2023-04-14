pipeline{
    agent any

    stages{

        stage('Build Docker image'){
            steps{
                script{
                    dockerapp = docker.build("celsinhobueno/painel:${env.BUILD_ID}", '-f ./Dockerfile ./')
                }
            }
        }

        stage('Push Docker image'){
            step{
                script{
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub'){
                        dockerapp.push('latest')
                        dockerapp.push("${env.BUILD_ID}")
                    }                    
                }
            }                   
        }
        
        stage('Deploy Kubernetes'){
            steps{
                step{
                    'sh echo "saldações"'
                }
            }
        }
    }
    
}