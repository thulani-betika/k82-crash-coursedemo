#!/bin/bash

# Setup script for kind (Kubernetes in Docker)
# This script creates a kind cluster with ingress support

set -e

echo "🚀 Setting up kind cluster for K8s Demo..."

# Create kind cluster with ingress support
cat <<EOF | kind create cluster --name k8s-demo --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  kubeadmConfigPatches:
  - |
    kind: InitConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "ingress-ready=true"
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    protocol: TCP
  - containerPort: 443
    hostPort: 443
    protocol: TCP
EOF

echo "⏳ Waiting for cluster to be ready..."
kubectl wait --for=condition=Ready nodes --all --timeout=300s

echo "📦 Installing NGINX Ingress Controller..."
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

echo "⏳ Waiting for ingress controller to be ready..."
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=300s

echo "✅ Kind cluster setup complete!"
echo ""
echo "Next steps:"
echo "1. Run: skaffold dev"
echo "2. Access the app at: http://localhost"
echo "3. API available at: http://localhost/api"
echo ""
echo "To delete the cluster: kind delete cluster --name k8s-demo"
