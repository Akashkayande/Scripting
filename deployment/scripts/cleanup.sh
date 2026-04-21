#!/bin/bash
set -euo pipefail

# Load config
if [ ! -f ../config/config.sh ]; then
  echo "[ERROR] config.sh not found!"
  exit 1
fi

source ../config/config.sh

echo "⚠️  WARNING: This will DELETE all resources!"
echo "Cluster: $CLUSTER_NAME"
echo "ECR Backend Repo: $ECR_REPO_BACKEND"
echo "ECR Frontend Repo: $ECR_REPO_FRONTEND"
echo ""

read -p "Are you sure you want to continue? (yes/no): " confirm

if [ "$confirm" != "yes" ]; then
  echo "❌ Cleanup aborted."
  exit 0
fi

echo "🧹 Starting cleanup..."


if eksctl get cluster --name "$CLUSTER_NAME" --region "$AWS_REGION" >/dev/null 2>&1; then
  echo "[INFO] Deleting EKS cluster..."
  eksctl delete cluster --name "$CLUSTER_NAME" --region "$AWS_REGION"
else
  echo "[INFO] EKS cluster not found, skipping..."
fi

delete_ecr_repo() {
  local repo_name=$1

  if aws ecr describe-repositories --repository-names "$repo_name" >/dev/null 2>&1; then
    echo "[INFO] Deleting ECR repository: $repo_name"
    aws ecr delete-repository --repository-name "$repo_name" --force
  else
    echo "[INFO] ECR repo $repo_name not found, skipping..."
  fi
}

delete_ecr_repo "$ECR_REPO_BACKEND"
delete_ecr_repo "$ECR_REPO_FRONTEND"

echo "✅ Cleanup completed successfully!"