# Kubernetes Workshop Guide

This guide walks through the Kubernetes concepts demonstrated in this project.

## 🎯 Learning Objectives

By the end of this workshop, you will understand:

- Container orchestration with Kubernetes
- Microservices architecture patterns
- Service discovery and load balancing
- Health monitoring and observability
- Development workflows with Skaffold

## 📚 Workshop Outline

### 1. Project Overview (10 minutes)

**What we're building:**
- A microservices application with frontend and backend
- Containerized with Docker
- Deployed on Kubernetes
- Accessible via Ingress

**Architecture:**
```
Internet → Ingress → Services → Pods
                ├── Frontend Service → Frontend Pods
                └── Backend Service → Backend Pods
```

### 2. Containerization (15 minutes)

**Frontend Container:**
- React/Vite application
- Multi-stage Docker build
- Nginx for serving static files
- Health check endpoint

**Backend Container:**
- Node.js/Express API
- Security best practices
- Health check endpoints
- Resource optimization

**Key Concepts:**
- Multi-stage builds for optimization
- Non-root containers for security
- Health checks for reliability

### 3. Kubernetes Deployments (20 minutes)

**Deployment Features:**
- Replica management
- Rolling updates
- Health checks (liveness/readiness)
- Resource limits and requests
- Security contexts

**Hands-on:**
```bash
# View deployment status
kubectl get deployments -n k8s-demo

# Scale deployments
kubectl scale deployment k8s-demo-frontend --replicas=3 -n k8s-demo

# View pod details
kubectl describe pods -n k8s-demo
```

### 4. Service Discovery (15 minutes)

**Service Types:**
- ClusterIP (internal communication)
- NodePort (direct access)
- LoadBalancer (cloud integration)

**Service Features:**
- Load balancing
- Service discovery
- Health-based routing

**Hands-on:**
```bash
# View services
kubectl get services -n k8s-demo

# Test service connectivity
kubectl exec -it <pod-name> -n k8s-demo -- curl k8s-demo-api-service:8080/health
```

### 5. Ingress and External Access (15 minutes)

**Ingress Features:**
- Path-based routing
- Host-based routing
- SSL termination
- Load balancing

**Hands-on:**
```bash
# View ingress configuration
kubectl describe ingress -n k8s-demo

# Test external access
curl http://localhost/
curl http://localhost/api/status
```

### 6. Health Monitoring (10 minutes)

**Health Check Types:**
- Liveness probes (restart unhealthy pods)
- Readiness probes (traffic routing)
- Startup probes (slow-starting containers)

**Monitoring Commands:**
```bash
# View pod health
kubectl get pods -n k8s-demo

# View events
kubectl get events -n k8s-demo

# View logs
kubectl logs -l app=k8s-demo-api -n k8s-demo
```

### 7. Development Workflow (15 minutes)

**Skaffold Features:**
- Automated building
- Hot reloading
- Port forwarding
- Resource management

**Development Commands:**
```bash
# Start development
skaffold dev

# One-time deployment
skaffold run

# Clean up
skaffold delete
```

## 🛠️ Hands-on Exercises

### Exercise 1: Scaling
Scale the frontend to 5 replicas and observe the load distribution.

### Exercise 2: Rolling Updates
Modify the backend code and observe the rolling update process.

### Exercise 3: Resource Limits
Adjust CPU and memory limits to see how Kubernetes handles resource constraints.

### Exercise 4: Health Checks
Simulate a pod failure and observe the automatic recovery.

## 🔍 Troubleshooting Scenarios

### Scenario 1: Pods Not Starting
- Check resource constraints
- Verify image availability
- Review security contexts

### Scenario 2: Services Not Accessible
- Verify service selectors
- Check endpoint availability
- Test network connectivity

### Scenario 3: Ingress Not Working
- Verify ingress controller
- Check ingress rules
- Test DNS resolution

## 📊 Monitoring and Observability

### Key Metrics to Monitor:
- Pod health and status
- Resource utilization
- Network connectivity
- Application logs

### Useful Commands:
```bash
# Resource usage
kubectl top pods -n k8s-demo

# Detailed pod information
kubectl describe pod <pod-name> -n k8s-demo

# Log streaming
kubectl logs -f -l app=k8s-demo-api -n k8s-demo
```

## 🚀 Next Steps

### Advanced Topics:
- ConfigMaps and Secrets
- Persistent Volumes
- Service Mesh (Istio)
- Helm charts
- GitOps workflows

### Production Considerations:
- Resource optimization
- Security hardening
- Monitoring and alerting
- Backup and disaster recovery

## 📚 Additional Resources

- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Skaffold Documentation](https://skaffold.dev/docs/)
- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)
- [Kubernetes Security Best Practices](https://kubernetes.io/docs/concepts/security/)

## 🎓 Assessment

### Knowledge Check:
1. What is the difference between a Deployment and a Service?
2. How do health checks improve application reliability?
3. What are the benefits of using Ingress over NodePort?
4. How does Skaffold improve the development workflow?

### Practical Tasks:
1. Deploy the application to a cloud provider
2. Implement a custom health check endpoint
3. Configure resource limits for production
4. Set up monitoring and alerting

## 🤝 Discussion Points

- Microservices vs. monoliths
- Container orchestration benefits
- Cloud-native development practices
- DevOps and GitOps workflows
