#!/bin/bash

echo "🚀 Deploying Kubernetes Demo Application..."

# Create namespace
echo "📁 Creating namespace..."
kubectl apply -f k8s-namespace/

# Deploy applications
echo "🔧 Deploying applications..."
kubectl apply -f k8s/

# Wait for deployments to be ready
echo "⏳ Waiting for deployments to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/frontend-deployment -n demo
kubectl wait --for=condition=available --timeout=300s deployment/api-deployment -n demo

# Check pod status
echo "📊 Checking pod status..."
kubectl get pods -n demo

# Check services
echo "🔗 Checking services..."
kubectl get services -n demo

# Check ingress (if available)
echo "🌐 Checking ingress..."
kubectl get ingress -n demo

echo ""
echo "✅ Deployment completed!"
echo ""
echo "📋 Access Information:"
echo "===================="
echo "Frontend (NodePort): http://localhost:30080"
echo "API (NodePort): http://localhost:30081"
echo ""
echo "If you have an Ingress Controller installed:"
echo "Frontend: http://localhost/"
echo "API: http://localhost/api/hello"
echo ""
echo "🔍 To check logs:"
echo "kubectl logs -f deployment/frontend-deployment -n demo"
echo "kubectl logs -f deployment/api-deployment -n demo"
echo ""
echo "🧹 To clean up:"
echo "kubectl delete namespace demo"
