# Kubernetes Crash Course Workshop

## Agenda
1. Intro: What is Kubernetes, why do we need it?
2. Deploy a backend API
3. Expose it as a Service
4. Deploy a frontend that consumes the API
5. Scale the API with `kubectl scale`
6. Perform a rolling update
7. Cleanup

---

## Steps

### 1. Setup
```bash
git clone https://github.com/<your-username>/k8s-crash-course-demo.git
cd k8s-crash-course-demo
```

### 2. Deploy Namespace
```bash
kubectl apply -f k8s/namespace.yaml
```

### 3. Deploy API
```bash
kubectl apply -f k8s/deployment-api.yaml -f k8s/service-api.yaml
kubectl get pods -n demo
kubectl get svc -n demo
```

### 4. Deploy Frontend
```bash
kubectl apply -f k8s/deployment-frontend.yaml -f k8s/service-frontend.yaml
kubectl get pods -n demo
kubectl get svc -n demo
```

Access frontend:  
👉 `http://<minikube-ip>:30080`

### 5. Scale API
```bash
kubectl scale deployment api-deployment --replicas=4 -n demo
```

### 6. Rolling Update
Change the image tag in `deployment-api.yaml` → re-apply:
```bash
kubectl apply -f k8s/deployment-api.yaml
```

### 7. Cleanup
```bash
kubectl delete namespace demo
```
