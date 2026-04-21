#!/bin/bash
set -euo pipefail
source ../config/config.sh

cd mern-devsecops-eks/k8s

# Replace image dynamically

sed -i "s|image: .*backend:.*|image: $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO_BACKEND:$IMAGE_TAG|g" backend/backend-rollout.yaml

sed -i "s|image: .*frontend:.*|image: $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO_FRONTEND:$IMAGE_TAG|g" frontend/frontend-rollout.yaml

if kubectl get namespace $NAMESPACE > /dev/null 2>&1; then
  echo "[INFO] Namespace exists"
else
  kubectl create namespace $NAMESPACE
fi
kubectl apply -n $NAMESPACE -f .

kubectl get pods
kubectl get svc