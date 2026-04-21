#!/bin/bash
set -euo pipefail
source ../config/config.sh

create_repo_if_not_exists() {
  REPO_NAME=$1

  if aws ecr describe-repositories --repository-names "$REPO_NAME" \
      --region $AWS_REGION > /dev/null 2>&1; then
    echo "[INFO] ECR repo $REPO_NAME already exists"
  else
    echo "[INFO] Creating ECR repo $REPO_NAME"
    aws ecr create-repository --repository-name "$REPO_NAME" --region $AWS_REGION
  fi
}

create_repo_if_not_exists $ECR_REPO_BACKEND
create_repo_if_not_exists $ECR_REPO_FRONTEND

echo "Logging into ECR..."

aws ecr get-login-password --region $AWS_REGION | \
docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com