pipeline{
    agent any

    stages{

        stage('Build Docker image'){
            steps{
                script{
                    dockerapp = docker.build("celsinhobueno/painel:${env.BUILD_ID}", '-f ./APP/Dcokerfile ./APP')
                }
            }
        }
    }
    
}