# Kubernetes Crash Course Demo

This repository demonstrates the basics of Kubernetes as learned in the course:
**"Kubernetes Crash Course: Learn the Basics and Build a Microservice Application"**.

## 🚀 Features
- Simple API (Node.js Express)
- Frontend (HTML + Nginx)
- Kubernetes manifests (Deployments, Services, Namespace)
- Workshop guide for demos
- Deployable with `kubectl apply -f k8s/`

## 🛠 How to Run

1. Clone this repo
```bash
git clone https://github.com/yourusername/k8s-crash-course-demo.git
cd k8s-crash-course-demo
```

2. Build and push Docker images (replace `your-dockerhub-username`)
```bash
docker build -t your-dockerhub-username/k8s-api:latest ./app/api
docker push your-dockerhub-username/k8s-api:latest

docker build -t your-dockerhub-username/k8s-frontend:latest ./app/frontend
docker push your-dockerhub-username/k8s-frontend:latest
```

3. Apply Kubernetes manifests
```bash
kubectl apply -f k8s/
kubectl get pods -n demo
kubectl get svc -n demo
```

4. Access frontend at:
```
http://<minikube-ip>:30080
```

---

## 📖 Workshop
See [Workshop.md](Workshop.md) for the step-by-step guide.

---

## ✅ Learning Outcomes
- Deployments, Pods, and Services in Kubernetes
- Scaling and rolling updates
- Service-to-service communication (frontend → API)
- Delivering a microservice in a deployable state

