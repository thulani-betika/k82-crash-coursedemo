#!/bin/bash

# Script to run Skaffold with proper minikube Docker environment

echo "🐳 Configuring Docker to use minikube daemon..."
eval $(minikube docker-env)

echo "🔍 Verifying Docker environment..."
echo "DOCKER_HOST: $DOCKER_HOST"
echo "DOCKER_CERT_PATH: $DOCKER_CERT_PATH"
echo "DOCKER_TLS_VERIFY: $DOCKER_TLS_VERIFY"

# Check if port-forwarding is requested
echo "Starting port-forward..."
echo "🌐 Application is now available at: http://localhost:3000"
echo "📊 To check status: make status"
echo "📋 To view logs: make logs"
minikube addons enable ingress
echo "🛑 To stop port-forward: pkill -f 'kubectl port-forward'"
kubectl port-forward -n ingress-nginx svc/ingress-nginx-controller 3000:80