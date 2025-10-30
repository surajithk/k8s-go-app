# K8s Go App

A simple "Hello World" web application built with Go, containerized with Docker, and ready for Kubernetes deployment.

## 📋 Overview

This project demonstrates a complete DevOps pipeline from a simple Go web application to a production-ready Kubernetes deployment:

- **Go Web Server**: Serves "Hello World!" on port 8080
- **Docker Container**: Multi-stage build for optimized image size
- **Kubernetes Ready**: Complete K8s manifests for deployment, service, and ingress
- **Production Features**: Health checks, resource limits, and security best practices

## 🚀 Quick Start

### Prerequisites

- [Go](https://golang.org/dl/) (1.19 or later)
- [Docker](https://docs.docker.com/get-docker/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- Kubernetes cluster (local or cloud)

### Running Locally

```bash
# Clone the repository
git clone https://github.com/surajithk/k8s-go-app.git
cd k8s-go-app

# Run with Go
go run cool_app.go

# Test the application
curl http://localhost:8080
```

## 🐳 Docker

### Build and Run

```bash
# Build the Docker image
docker build -t k8s-go-app .

# Run the container
docker run -d -p 8080:8080 --name k8s-go-app-container k8s-go-app

# Test the containerized app
curl http://localhost:8080
```

### Push to Docker Hub

```bash
# Tag for Docker Hub (replace with your username)
docker tag k8s-go-app YOUR_DOCKERHUB_USERNAME/k8s-go-app:latest

# Login to Docker Hub
docker login

# Push the image
docker push YOUR_DOCKERHUB_USERNAME/k8s-go-app:latest
```

## ☸️ Kubernetes Deployment

### Quick Deploy

```bash
# Make the deploy script executable
chmod +x deploy.sh

# Deploy to Kubernetes
./deploy.sh
```

### Manual Deployment

```bash
# Apply the manifests
kubectl apply -f k8s-deployment.yaml
kubectl apply -f k8s-service.yaml
kubectl apply -f k8s-ingress.yaml

# Check the deployment
kubectl get pods -l app=k8s-go-app
kubectl get services
```

### Access the Application

#### Using LoadBalancer (Cloud providers)
```bash
kubectl get service k8s-go-app-service
# Use the EXTERNAL-IP to access the app
```

#### Using NodePort (Local clusters like minikube)
```bash
minikube service k8s-go-app-service
```

#### Using Ingress
```bash
# Add to /etc/hosts
echo "$(kubectl get ingress k8s-go-app-ingress -o jsonpath='{.status.loadBalancer.ingress[0].ip}') k8s-go-app.local" >> /etc/hosts

# Access via browser
open http://k8s-go-app.local
```

## 📁 Project Structure

```
k8s-go-app/
├── cool_app.go              # Go web application
├── Dockerfile               # Multi-stage Docker build
├── .dockerignore           # Docker build exclusions
├── k8s-deployment.yaml     # Kubernetes deployment
├── k8s-service.yaml        # Kubernetes service
├── k8s-ingress.yaml        # Kubernetes ingress
├── deploy.sh               # Deployment automation script
├── LICENSE                 # Project license
└── README.md               # This file
```

## 🔧 Configuration

### Environment Variables

The application currently doesn't use environment variables, but you can extend it:

```go
port := os.Getenv("PORT")
if port == "" {
    port = "8080"
}
```

### Kubernetes Resources

The deployment is configured with:
- **Replicas**: 3 pods for high availability
- **Resource Limits**: 500m CPU, 128Mi memory
- **Health Checks**: Liveness and readiness probes
- **Security**: Non-root user in container

## 🛠️ Development

### Extending the Application

1. **Add new endpoints**:
```go
http.HandleFunc("/health", healthHandler)
http.HandleFunc("/api/users", usersHandler)
```

2. **Add environment configuration**:
```go
type Config struct {
    Port string `env:"PORT" envDefault:"8080"`
    Debug bool `env:"DEBUG" envDefault:"false"`
}
```

3. **Add logging**:
```go
import "log"

func main() {
    log.Println("Starting server on port 8080...")
    // ... rest of the code
}
```

### Testing

```bash
# Run tests (when you add them)
go test ./...

# Build and test Docker image
docker build -t k8s-go-app:test .
docker run --rm -p 8080:8080 k8s-go-app:test
```

## 🔐 Security Features

- **Non-root user**: Container runs as user ID 1001
- **Minimal base image**: Uses Alpine Linux for smaller attack surface
- **Resource limits**: Prevents resource exhaustion
- **Health checks**: Kubernetes can detect and restart unhealthy pods

## 📊 Monitoring

### Basic Health Check

```bash
# Check pod status
kubectl get pods -l app=k8s-go-app

# Check logs
kubectl logs -l app=k8s-go-app

# Describe deployment
kubectl describe deployment k8s-go-app-deployment
```

### Scaling

```bash
# Scale the deployment
kubectl scale deployment k8s-go-app-deployment --replicas=5

# Check scaling status
kubectl rollout status deployment/k8s-go-app-deployment
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Go community for the excellent tooling
- Docker for containerization
- Kubernetes for orchestration
- Alpine Linux for the minimal base image