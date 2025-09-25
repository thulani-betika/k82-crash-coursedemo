# Kubernetes Demo Makefile
# Skaffold-focused deployment commands

.PHONY: help setup-minikube dev serve deploy status logs clean clean-minikube

# Default target
help:
	@echo "Kubernetes Demo - Skaffold Commands:"
	@echo ""
	@echo "Setup:"
	@echo "  setup-minikube  - Start minikube with ingress"
	@echo ""
	@echo "Development (Skaffold):"
	@echo "  dev             - Start development with Skaffold (watch mode)"
	@echo "  serve           - Deploy with Skaffold and start port-forwarding"
	@echo "  deploy          - Deploy with Skaffold"
	@echo "  quick-start     - Setup minikube and start development"
	@echo ""
	@echo "Management:"
	@echo "  status          - Show cluster status"
	@echo "  logs            - Show application logs"
	@echo "  url             - Show application URLs"
	@echo "  clean           - Clean up resources"
	@echo ""
	@echo "Cleanup:"
	@echo "  clean-minikube  - Stop minikube"

setup-minikube:
	@echo "🚀 Setting up minikube..."
	@chmod +x setup-minikube.sh
	@./setup-minikube.sh

# Development commands (Skaffold-based)
dev:
	@echo "🚀 Starting development with Skaffold (watch mode)..."
	@./run-skaffold.sh

deploy:
	@echo "🚀 Deploying with Skaffold..."
	@./deploy.sh

serve:
	@echo "🚀 Deploying with Skaffold and starting port-forwarding..."
	@./run-skaffold.sh

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

clean-minikube:
	@echo "🧹 Stopping minikube..."
	minikube stop
	@echo "✅ Minikube stopped"

# Quick start command
quick-start: setup-minikube dev
	@echo "✅ Quick start with minikube complete!"

# Get application URL
url:
	@echo "🌐 Application URLs:"
	@echo "  Frontend: http://localhost:3000"
	@echo "  API: http://localhost:3000/api/users"
	@echo "  API Status: http://localhost:3000/api/status"
