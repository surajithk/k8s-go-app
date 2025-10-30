#!/bin/bash

# Deploy K8s Go App
echo "🚀 Deploying K8s Go App..."

# Apply the deployment
echo "📦 Creating deployment..."
kubectl apply -f k8s-deployment.yaml

# Apply the service
echo "🌐 Creating service..."
kubectl apply -f k8s-service.yaml

# Apply the ingress (optional)
echo "🔗 Creating ingress..."
kubectl apply -f k8s-ingress.yaml

# Wait for rollout to complete
echo "⏳ Waiting for deployment to be ready..."
kubectl rollout status deployment/k8s-go-app-deployment

# Get deployment status
echo "📊 Deployment Status:"
kubectl get deployments

echo "🔍 Pods:"
kubectl get pods -l app=k8s-go-app

echo "🌐 Services:"
kubectl get services

echo "🔗 Ingress:"
kubectl get ingress

echo "✅ Deployment complete!"
echo ""
echo "To access your app:"
echo "1. If using LoadBalancer: kubectl get service k8s-go-app-service"
echo "2. If using NodePort: minikube service k8s-go-app-service"
echo "3. If using Ingress: Add 'k8s-go-app.local' to your /etc/hosts pointing to your ingress IP"