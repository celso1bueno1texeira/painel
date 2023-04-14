#!/bin/sh
#############################################################################
######                                                                #######
###### Criado do Celso Bueno  para automação de pipeline, 14/04/2023. #######
######     Jenkins                                                    #######  
######                                                                #######
######  Função: Verificar se existe o service, se não existir, criar. #######
######                                                                #######
######                                                                #######
#############################################################################


NAMESPACE=default
DEPLOYMENT=painel-tools
SECRET=$DEPLOYMENT-service

if [ ! -z "$(kubectl get service --namespace=$NAMESPACE | grep $SECRET)" ]
then
    sh 'echo = "o service já existe!!!"'
else
    sh 'kubectl apply -f ./k8s/api/service.yaml'
fi