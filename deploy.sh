#!/bin/bash

# Deployment script for Kubernetes Demo
# This script provides a simple way to deploy the application

set -e

echo "🚀 Kubernetes Demo Deployment Script"
echo "====================================="

# Check if kubectl is available
if ! command -v kubectl &> /dev/null; then
    echo "❌ kubectl is not installed. Please install kubectl first."
    exit 1
fi

# Check if skaffold is available
if ! command -v skaffold &> /dev/null; then
    echo "❌ skaffold is not installed. Please install skaffold first."
    exit 1
fi

# Function to check cluster connectivity
check_cluster() {
    echo "🔍 Checking cluster connectivity..."
    if ! kubectl cluster-info &> /dev/null; then
        echo "❌ Cannot connect to Kubernetes cluster. Please ensure your cluster is running."
        exit 1
    fi
    echo "✅ Cluster connectivity confirmed"
}

# Function to deploy with skaffold
deploy_with_skaffold() {
    echo "🚀 Deploying with Skaffold..."
    skaffold run
    echo "✅ Deployment completed with Skaffold"
}

# Function to deploy manually
deploy_manual() {
    echo "🔨 Building Docker images..."
    docker build -t k8s-demo-frontend ./app/frontend
    docker build -t k8s-demo-api ./app/api
    
    echo "🚀 Deploying to Kubernetes..."
    kubectl apply -f k8s/
    
    echo "⏳ Waiting for deployments to be ready..."
    kubectl wait --for=condition=available --timeout=300s deployment/k8s-demo-frontend -n k8s-demo
    kubectl wait --for=condition=available --timeout=300s deployment/k8s-demo-api -n k8s-demo
    
    echo "✅ Manual deployment completed"
}

# Function to show status
show_status() {
    echo "📊 Deployment Status:"
    echo ""
    echo "Namespaces:"
    kubectl get namespaces | grep k8s-demo || echo "No k8s-demo namespace found"
    echo ""
    echo "Pods:"
    kubectl get pods -n k8s-demo
    echo ""
    echo "Services:"
    kubectl get services -n k8s-demo
    echo ""
    echo "Ingress:"
    kubectl get ingress -n k8s-demo
    echo ""
    echo "To view logs:"
    echo "  kubectl logs -l app=k8s-demo-frontend -n k8s-demo"
    echo "  kubectl logs -l app=k8s-demo-api -n k8s-demo"
}

# Function to show access information
show_access_info() {
    echo "🌐 Access Information:"
    echo ""
    
    # Check if running in minikube
    if kubectl config current-context | grep -q minikube; then
        MINIKUBE_IP=$(minikube ip 2>/dev/null || echo "unknown")
        echo "Minikube detected. Access URLs:"
        echo "  Frontend: http://$MINIKUBE_IP"
        echo "  Backend API: http://$MINIKUBE_IP/api"
    else
        echo "Access URLs (assuming localhost):"
        echo "  Frontend: http://localhost"
        echo "  Backend API: http://localhost/api"
    fi
    
    echo ""
    echo "To get the external IP of your ingress:"
    echo "  kubectl get ingress -n k8s-demo"
}

# Main script logic
case "${1:-skaffold}" in
    "skaffold")
        check_cluster
        deploy_with_skaffold
        show_status
        show_access_info
        ;;
    "manual")
        check_cluster
        deploy_manual
        show_status
        show_access_info
        ;;
    "status")
        show_status
        ;;
    "help"|"-h"|"--help")
        echo "Usage: $0 [skaffold|manual|status|help]"
        echo ""
        echo "Commands:"
        echo "  skaffold  - Deploy using Skaffold (default)"
        echo "  manual   - Deploy manually with kubectl"
        echo "  status   - Show deployment status"
        echo "  help     - Show this help message"
        ;;
    *)
        echo "❌ Unknown command: $1"
        echo "Use '$0 help' for usage information"
        exit 1
        ;;
esac
