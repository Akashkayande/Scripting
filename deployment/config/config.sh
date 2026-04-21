#!/bin/bash
set -euo pipefail
export AWS_REGION="ap-south-1"
export CLUSTER_NAME="mern-eks"
export ECR_REPO_BACKEND="backend"
export ECR_REPO_FRONTEND="frontend"
NODE_TYPE=t3.medium
NODE_COUNT=2
$NAMESPACE=mern-prod

export ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

export IMAGE_TAG="latest"

export APP_REPO="https://github.com/Akashkayande/mern-devsecops-eks.git"