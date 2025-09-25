# Kubernetes Crash Course Demo

A complete Kubernetes demo project showcasing microservices deployment with frontend and backend components. This project demonstrates real-world Kubernetes concepts including deployments, services, ingress, health checks, and automated development workflows.

## 🏗️ Architecture

- **Frontend**: React/Vite application served on port 3000
- **Backend**: Node.js/Express API served on port 8080
- **Ingress**: Exposes frontend at `/` and backend at `/api`
- **Kubernetes**: Deployments, Services, Ingress with health checks

## 
```bash
# Switch to Minikube's Docker Daemon
eval $(minikube docker-env)
```

## 📋 Prerequisites
- Docker
- Kubernetes cluster (minikube, or cloud provider)
- Skaffold (for automated deployment)
- kubectl

### Installing Prerequisites

```bash
# Install Skaffold
curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64
sudo install skaffold /usr/local/bin/

# Install minikube (alternative to kind)
curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-darwin-arm64
sudo install minikube-darwin-arm64 /usr/local/bin/minikube
```

## 🚀 Quick Start

### Setup App

```bash
# For minikube  
make deploy

# Expose the app for external access
make serve
```



3. **Access the application:**
   - Frontend: http://localhost:3000
   - Backend API: http://localhost:3000/api

## 📁 Project Structure

```
├── app/
│   ├── frontend/          # React/Vite frontend
│   │   ├── src/
│   │   ├── Dockerfile
│   │   └── package.json
│   └── api/              # Node.js/Express backend
│       ├── server.js
│       ├── Dockerfile
│       └── package.json
├── k8s/                  # Kubernetes manifests
│   ├── namespace.yaml
│   ├── deployment-*.yaml
│   ├── service-*.yaml
│   └── ingress.yaml
├── skaffold.yaml        # Skaffold configuration
├── Makefile             # Convenient commands
├── deploy.sh            # Simplified Skaffold deployment script
├── run-skaffold.sh      # Port forwarding script
├── setup-minikube.sh    # Minikube setup script
└── README.md
```

## ✨ Features

- ✅ **Containerized Applications**: Docker containers for both frontend and backend
- ✅ **Kubernetes Deployments**: Multi-replica deployments with health checks
- ✅ **Service Discovery**: ClusterIP services for internal communication
- ✅ **Ingress Routing**: External access with path-based routing
- ✅ **Health Checks**: Liveness and readiness probes
- ✅ **Development Workflow**: Skaffold for automated build/deploy

## 🛠️ Development Commands

```bash
# Development
make build            # Build Docker images
make deploy           # Deploy to Kubernetes

# Monitoring
make status           # Show cluster status
make logs             # Show application logs

# Cleanup
make clean            # Clean up resources
make clean-kind       # Delete kind cluster
make clean-minikube   # Stop minikube
```

## 🔧 Configuration

### Skaffold Profiles

- **dev**: Local development with port forwarding

### Environment Variables

The backend API supports these environment variables:
- `NODE_ENV`: Environment (development/production)
- `PORT`: Server port (default: 8080)

### Ingress Configuration

The ingress is configured for:
- Frontend: `/` → k8s-demo-frontend-service:3000
- Backend: `/api` → k8s-demo-api-service:3000

## 🐛 Troubleshooting

### Common Issues

1. **Images not found**: Ensure Docker images are built and available
2. **Ingress not working**: Check if ingress controller is installed
3. **Port conflicts**: Ensure ports 80/443 are available for ingress

### Debug Commands

```bash
# Check pod status
kubectl get pods -n k8s-demo

# Check service endpoints
kubectl get endpoints -n k8s-demo

# Check ingress status
kubectl describe ingress -n k8s-demo

# View logs
kubectl logs -l app=k8s-demo-frontend -n k8s-demo
kubectl logs -l app=k8s-demo-api -n k8s-demo
```

```bash
# Port forward
kubectl port-forward service/k8s-demo-frontend-service 3000:3000 -n k8s-demo
```


## 📚 Learning Resources

This demo showcases:
- Container orchestration with Kubernetes
- Microservices architecture
- Service mesh concepts
- Health monitoring and observability
- CI/CD with Skaffold
- Cloud-native development practices

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test with `make dev`
5. Submit a pull request

## 📄 License

MIT License - see LICENSE file for details
