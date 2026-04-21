#!/bin/bash
set -euo pipefail

cd scripts

run_step() {
  echo "👉 Running $1..."
  bash "$1" || { echo "❌ Failed at $1"; exit 1; }
}

run_step setup.sh
run_step config.sh
run_step eks.sh
run_step ecr.sh
run_step docker.sh
run_step k8.sh

echo "🚀 MERN App deployed successfully on EKS!"