#!/bin/bash
set -euo pipefail
source ../config/config.sh

if eksctl get cluster --name $CLUSTER_NAME --region $AWS_REGION > /dev/null 2>&1; then
  echo "[INFO] EKS cluster already exists. Skipping..."
else
  echo "[INFO] Creating EKS cluster..."
  eksctl create cluster \
    --name $CLUSTER_NAME \
    --region $AWS_REGION \
    --nodegroup-name standard-workers \
    --node-type $NODE_TYPE \
    --nodes $NODE_COUNT
fi
echo "Updating kubeconfig..."

aws eks --region $AWS_REGION update-kubeconfig --name $CLUSTER_NAME

kubectl get nodes