#!/bin/sh

eval `minikube docker-env`
docker build -t placedock:1.0 .
kubectl apply -f deployment.yaml
kubectl expose deployment placement-deployment --type=LoadBalancer
PLACEMENT=`minikube service placement-deployment --url`

curl -H 'x-auth-token: admin' $PLACEMENT 
echo

if `which -s gabbi-run`; then
    gabbi-run -v all $PLACEMENT -- gabbi.yaml
fi
