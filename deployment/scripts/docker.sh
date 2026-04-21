#!/bin/bash
set -euo pipefail
source ../config/config.sh

# Clone app repo
if [ ! -d "mern-devsecops-eks" ]; then
  git clone $APP_REPO
else
  echo "[INFO] Repo exists. Pulling latest code..."
  cd mern-devsecops-eks && git pull
fi

cd mern-devsecops-eks

# backend
docker build -t $ECR_REPO_BACKEND ./server
docker tag $ECR_REPO_BACKEND:latest \
$ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO_BACKEND:$IMAGE_TAG

docker push $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO_BACKEND:$IMAGE_TAG

# frontend
docker build -t $ECR_REPO_FRONTEND ./client  
docker tag $ECR_REPO_FRONTEND:latest \
$ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO_FRONTEND:$IMAGE_TAG

docker push $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO_FRONTEND:$IMAGE_TAG

