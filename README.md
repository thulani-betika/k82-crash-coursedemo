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
kubectl apply -f k8s-namespace/
kubectl apply -f k8s/
kubectl get pods -n demo
kubectl get svc -n demo
```

4. Apply Kubernetes manifests
```bash
kubectl get all -n demo
```

#### You should see an output such as:
```bash
k8s-crash-course-demo git:(main) kubectl get all -n demo
NAME                                       READY   STATUS    RESTARTS   AGE
pod/api-deployment-5d46455c5d-k724b        1/1     Running   0          85s
pod/api-deployment-5d46455c5d-mbkwb        1/1     Running   0          85s
pod/frontend-deployment-5777788dd9-qmltj   1/1     Running   0          85s

NAME                       TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/api-service        ClusterIP   10.107.249.33   <none>        80/TCP         2m25s
service/frontend-service   NodePort    10.99.1.230     <none>        80:30080/TCP   2m25s

NAME                                  READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/api-deployment        2/2     2            2           85s
deployment.apps/frontend-deployment   1/1     1            1           85s

NAME                                             DESIRED   CURRENT   READY   AGE
replicaset.apps/api-deployment-5d46455c5d        2         2         2       85s
replicaset.apps/frontend-deployment-5777788dd9   1         1         1       85s
````

5. Access frontend at:
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

