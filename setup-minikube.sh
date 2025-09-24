#!/bin/bash

# Setup script for minikube
# This script starts minikube with ingress support

set -e

echo "🚀 Setting up minikube for K8s Demo..."

# Start minikube with ingress addon
echo "Starting minikube..."
minikube start --driver=docker --memory=4096 --cpus=2

echo "📦 Enabling ingress addon..."
minikube addons enable ingress

echo "⏳ Waiting for ingress controller to be ready..."
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=300s

echo "✅ Minikube setup complete!"
echo ""
echo "Next steps:"
echo "1. Run: skaffold dev"
echo "2. Get the minikube IP: minikube ip"
echo "3. Access the app at: http://\$(minikube ip)"
echo "4. API available at: http://\$(minikube ip)/api"
echo ""
echo "To stop minikube: minikube stop"
echo "To delete minikube: minikube delete"
