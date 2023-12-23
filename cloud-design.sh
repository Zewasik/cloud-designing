#!/bin/bash

if [ $# -lt 1 ] || [ $# -gt 2 ]; then
    echo To use this program ./cloud-design.sh [OPTION]
    echo
    echo Option list:
    echo " - create             | creates new kubernetes cluster using AWS"
    echo " - start              | start cluster using manifest files"
    echo " - update-config      | stop cluster using manifest files"
    echo " - info               | get info about everything in cluster"
    echo "      - pods          | get info about all pods"
    echo "      - services      | get info about all services"
    echo "      - elb-hostname  | get LoadBalancer hostname"
    echo " - stop               | stops application using manifest files"
    exit 1
fi

case $1 in
"create")
    terraform init
    terraform apply -auto-approve

    echo
    echo "Successfully created. To continue use ./cloud-design.sh update-config for updating current kubernetes configuration"
    ;;
"start")
    kubectl apply -f ./manifests/
    ;;
"info")
    case "$2" in
    "pods")
        kubectl get pods
        ;;
    "services")
        kubectl get svc
        ;;
    "elb-hostname")
        echo "$(kubectl get svc api-gateway-app-service -o=jsonpath='{.status.loadBalancer.ingress[0].hostname}'):$(kubectl get svc api-gateway-app-service -o=jsonpath='{.spec.ports[0].targetPort}')"
        ;;
    *)
        kubectl get all
        ;;
    esac
    ;;

"stop")
    kubectl delete -f ./manifests/
    terraform destroy -auto-approve
    ;;
"update-config")
    aws eks update-kubeconfig --region $(terraform output -raw region) --name $(terraform output -raw cluster_name)

    echo
    echo "Successfully updated config. To continue use ./cloud-design.sh start for starting application"
    ;;
*)
    exit 1
    ;;
esac
