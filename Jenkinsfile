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
            steps {
                script{
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub'){
                        dockerapp.push('latest')
                        dockerapp.push("${env.BUILD_ID}")
                    }                    
                }
            }                   
        }
        stage('Deploy Service'){
            steps{
                withKubeConfig([credentialsId: 'kubeconfig']){
                    if[service.painel-tools == 'true'];
                        sh 'kubectl apply -f ./k8s/api/service.yaml'
                }
            }
        }
        
        stage('Deploy Kubernetes'){
            environment{
                tag_version = "${env.BUILD_ID}"
            }
            steps{
                withKubeConfig([credentialsId: 'kubeconfig']){
                    sh 'sed -i "s/{{TAG}}/$tag_version/g" ./k8s/api/deployment.yaml'
                    sh 'kubectl apply -f ./k8s/api/deployment.yaml'
                }
            }
        }
    }
    
}