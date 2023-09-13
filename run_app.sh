#!/bin/bash

# Start Minikube
minikube start

# Create ConfigMap
kubectl create configmap nginx-config --from-file=nginx-config.conf

# Create secret
kubectl create secret tls secret-tls --cert=certifications/nginx.crt --key=certifications/nginx.key

# Deploy Manifests
kubectl apply -f dcoya-app.yaml -f dcoya-service.yaml -f nginx.yaml -f nginx-service.yaml

# Wait for the resources
kubectl wait --for=condition=Available --timeout=30s deployment.apps/dcoya
kubectl wait --for=condition=Available --timeout=30s deployment.apps/nginx

# Start Minikube Tunnel in a new terminal and wait until it's running
gnome-terminal -- bash -c "minikube tunnel" &                                                       


# Use kubectl to check if the nginx-service has an external IP
EXTERNAL_IP=$(kubectl get svc nginx-service -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

# Check if the tunnel is ready
while [ -z "$EXTERNAL_IP"  ]; do    
    sleep 1 
    EXTERNAL_IP=$(kubectl get svc nginx-service -o jsonpath='{.status.loadBalancer.ingress[0].ip}')     
done

# Open the URL in the default browser
export APP_URL="${EXTERNAL_IP}"
xdg-open "http://${EXTERNAL_IP}" 

# Print the External IP
echo -e "\e[1;32mOpening browser at http://${EXTERNAL_IP}\e[0m"

