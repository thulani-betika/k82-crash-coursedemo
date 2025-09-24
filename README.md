# Kubernetes Crash Course Demo

A complete Kubernetes demo project showcasing microservices deployment with frontend and backend components. This project demonstrates real-world Kubernetes concepts including deployments, services, ingress, health checks, and automated development workflows.

## 🏗️ Architecture

- **Frontend**: React/Vite application served on port 3000
- **Backend**: Node.js/Express API served on port 8080
- **Ingress**: Exposes frontend at `/` and backend at `/api`
- **Kubernetes**: Deployments, Services, Ingress with health checks

## 📋 Prerequisites

- Docker
- Kubernetes cluster (kind, minikube, or cloud provider)
- Skaffold (for automated deployment)
- kubectl

### Installing Prerequisites

```bash
# Install Skaffold
curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64
sudo install skaffold /usr/local/bin/

# Install kind (for local development)
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

# Install minikube (alternative to kind)
curl -Lo minikube https://storage.k8s.io/releases/latest/minikube-linux-amd64
sudo install minikube /usr/local/bin/
```

## 🚀 Quick Start

### Option 1: Automated Setup (Recommended)

```bash
# For kind
make quick-start-kind

# For minikube  
make quick-start-minikube
```

### Option 2: Manual Setup

#### Using kind

1. **Setup kind cluster:**
   ```bash
   make setup-kind
   ```

2. **Start development:**
   ```bash
   make dev
   ```

3. **Access the application:**
   - Frontend: http://localhost
   - Backend API: http://localhost/api

#### Using minikube

1. **Setup minikube:**
   ```bash
   make setup-minikube
   ```

2. **Start development:**
   ```bash
   make dev
   ```

3. **Get minikube IP and access:**
   ```bash
   minikube ip
   # Access at http://<minikube-ip>
   ```

### Option 3: Manual Deployment

1. **Build images:**
   ```bash
   make build
   ```

2. **Deploy to Kubernetes:**
   ```bash
   make deploy
   ```

3. **Check status:**
   ```bash
   make status
   ```

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
├── skaffold.yaml         # Skaffold configuration
├── Makefile             # Convenient commands
├── setup-kind.sh        # Kind setup script
├── setup-minikube.sh    # Minikube setup script
└── README.md
```

## ✨ Features

- ✅ **Containerized Applications**: Docker containers for both frontend and backend
- ✅ **Kubernetes Deployments**: Multi-replica deployments with health checks
- ✅ **Service Discovery**: ClusterIP services for internal communication
- ✅ **Ingress Routing**: External access with path-based routing
- ✅ **Health Checks**: Liveness and readiness probes
- ✅ **Security**: Non-root containers with security contexts
- ✅ **Resource Management**: CPU and memory limits/requests
- ✅ **Development Workflow**: Skaffold for automated build/deploy
- ✅ **Multi-Platform**: Compatible with kind, minikube, and cloud providers

## 🛠️ Development Commands

```bash
# Development
make dev              # Start development with Skaffold
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

## 🌐 Cloud Provider Deployment

The manifests are designed to work on any Kubernetes cluster:

### Google Kubernetes Engine (GKE)
```bash
# Create cluster
gcloud container clusters create k8s-demo --zone=us-central1-a

# Deploy
skaffold run --profile=prod
```

### Amazon EKS
```bash
# Create cluster
eksctl create cluster --name k8s-demo --region us-west-2

# Deploy
skaffold run
```

### Azure Kubernetes Service (AKS)
```bash
# Create cluster
az aks create --resource-group myResourceGroup --name k8s-demo

# Deploy
skaffold run
```

## 🔧 Configuration

### Skaffold Profiles

- **dev**: Local development with port forwarding
- **prod**: Production deployment with cloud build

### Environment Variables

The backend API supports these environment variables:
- `NODE_ENV`: Environment (development/production)
- `PORT`: Server port (default: 8080)

### Ingress Configuration

The ingress is configured for:
- Frontend: `/` → k8s-demo-frontend-service:3000
- Backend: `/api` → k8s-demo-api-service:8080

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
