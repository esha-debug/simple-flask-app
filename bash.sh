#!/bin/bash

# Login to DockerHub 
echo "$DOCKERHUB_PASSWORD" | docker login -u "$DOCKERHUB_USERNAME" --password-stdin

# Build Docker image
docker build -t hackler254/simple-flask-app:latest .

# Push to DockerHub
docker push hackler254/simple-flask-app:latest

# Install Kind 
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.11.1/kind-linux-amd64
chmod +x ./kind

# Set up Kubernetes cluster with Kind 
sudo kind create cluster --name kind

# Install kubectl 
sudo apt-get update
sudo apt-get install -y kubectl

# Load Docker image into Kind
sudo docker pull hackler254/simple-flask-app:latest
kind load docker-image hackler254/simple-flask-app:latest --name kind

# Deploy to Kind cluster 
kubectl apply -f k8s/app-deployment.yaml

# Get service info
kubectl get services

# Clean up Kind cluster
kind delete cluster --name kind