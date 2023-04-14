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
        
        stage('Deploy Kubernetes'){
            steps{
                withKubeconfig([credentialsId: 'kubeconfig', serverUrl: 'https://3e664d67-eb0e-4806-8097-e4eb10d4515a.k8s.ondigitalocean.com']){
                    sh 'kubectl apply -f ./k8s/deployment.yaml'
                }
            }
        }
    }
    
}