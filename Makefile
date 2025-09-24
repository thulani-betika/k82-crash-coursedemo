# Kubernetes Demo Makefile
# Provides convenient commands for development and deployment

.PHONY: help setup-kind setup-minikube build deploy clean status logs

# Default target
help:
	@echo "Kubernetes Demo - Available Commands:"
	@echo ""
	@echo "Setup:"
	@echo "  setup-kind      - Create kind cluster with ingress"
	@echo "  setup-minikube  - Start minikube with ingress"
	@echo ""
	@echo "Development:"
	@echo "  dev             - Start development with Skaffold"
	@echo "  build           - Build Docker images"
	@echo "  deploy          - Deploy to Kubernetes"
	@echo ""
	@echo "Management:"
	@echo "  status          - Show cluster status"
	@echo "  logs            - Show application logs"
	@echo "  clean           - Clean up resources"
	@echo ""
	@echo "Cleanup:"
	@echo "  clean-kind      - Delete kind cluster"
	@echo "  clean-minikube  - Stop minikube"

# Setup commands
setup-kind:
	@echo "🚀 Setting up kind cluster..."
	@chmod +x setup-kind.sh
	@./setup-kind.sh

setup-minikube:
	@echo "🚀 Setting up minikube..."
	@chmod +x setup-minikube.sh
	@./setup-minikube.sh

# Development commands
dev:
	@echo "🚀 Starting development with Skaffold..."
	skaffold dev

build:
	@echo "🔨 Building Docker images..."
	docker build -t k8s-demo-frontend ./app/frontend
	docker build -t k8s-demo-api ./app/api

deploy:
	@echo "🚀 Deploying to Kubernetes..."
	kubectl apply -f k8s/

# Status and monitoring
status:
	@echo "📊 Cluster Status:"
	@echo ""
	@echo "Namespaces:"
	kubectl get namespaces
	@echo ""
	@echo "Pods:"
	kubectl get pods -n k8s-demo
	@echo ""
	@echo "Services:"
	kubectl get services -n k8s-demo
	@echo ""
	@echo "Ingress:"
	kubectl get ingress -n k8s-demo

logs:
	@echo "📋 Application Logs:"
	@echo ""
	@echo "Frontend logs:"
	kubectl logs -l app=k8s-demo-frontend -n k8s-demo --tail=50
	@echo ""
	@echo "API logs:"
	kubectl logs -l app=k8s-demo-api -n k8s-demo --tail=50

# Cleanup commands
clean:
	@echo "🧹 Cleaning up resources..."
	kubectl delete namespace k8s-demo --ignore-not-found=true
	@echo "✅ Cleanup complete"

clean-kind:
	@echo "🧹 Deleting kind cluster..."
	kind delete cluster --name k8s-demo
	@echo "✅ Kind cluster deleted"

clean-minikube:
	@echo "🧹 Stopping minikube..."
	minikube stop
	@echo "✅ Minikube stopped"

# Quick start commands
quick-start-kind: setup-kind dev
	@echo "✅ Quick start with kind complete!"

quick-start-minikube: setup-minikube dev
	@echo "✅ Quick start with minikube complete!"
