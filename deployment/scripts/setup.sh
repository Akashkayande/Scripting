#!/bin/bash
set -euo pipefail

echo "Installing required tools..."

sudo apt update -y

echo "AWS CLI configured successfully!"

if ! command -v aws >/dev/null 2>&1; then
  echo "[INFO] Installing AWS CLI..."
  curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip -o awscliv2.zip >/dev/null
  sudo ./aws/install
else
  echo "[INFO] AWS CLI already installed"
fi

if [ ! -f ../.env ]; then
  echo ".env file not found!"
  exit 1
fi

set -a
source ../.env
set +a

echo "Configuring AWS CLI..."

aws configure set aws_access_key_id "$AWS_ACCESS_KEY_ID"
aws configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY"
aws configure set region "$AWS_REGION"


if ! command -v kubectl >/dev/null 2>&1; then
  echo "[INFO] Installing kubectl..."
  curl -s -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/latest/bin/linux/amd64/kubectl
  chmod +x kubectl
  sudo mv kubectl /usr/local/bin/
else
  echo "[INFO] kubectl already installed"
fi


if ! command -v eksctl >/dev/null 2>&1; then
  echo "[INFO] Installing eksctl..."
  curl --silent --location \
    "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_Linux_amd64.tar.gz" \
    | tar xz
  sudo mv eksctl /usr/local/bin
else
  echo "[INFO] eksctl already installed"
fi

if ! command -v docker >/dev/null 2>&1; then
  echo "[INFO] Installing Docker..."
  sudo apt update -y
  sudo apt install -y docker.io
  sudo systemctl enable docker
  sudo systemctl start docker
else
  echo "[INFO] Docker already installed"
fi

# Add user to docker group
if ! groups "$USER" | grep -q docker; then
  echo "[INFO] Adding $USER to docker group..."
  sudo usermod -aG docker "$USER"
  echo "[WARN] You must run: newgrp docker OR logout/login to use Docker without sudo"
else
  echo "[INFO] User already in docker group"
fi

echo "[INFO] Verifying tools..."

aws --version
kubectl version --client
eksctl version
docker --version

echo "[SUCCESS] All tools installed and configured!"