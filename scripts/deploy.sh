#!/bin/bash

# Create namespace
kubectl apply -f namespace.yaml

# Apply PostgreSQL secret and GCS secret
kubectl apply -f postgres/postgres-secret.yaml
kubectl apply -f gcs/gcs-secret.yaml

# Deploy PostgreSQL
helm install postgresql bitnami/postgresql -f postgres/postgres-values.yaml --namespace mlflow-ns

# Deploy MLflow
helm install mlflow community-charts/mlflow -f mlflow/mlflow-values.yaml --namespace mlflow-ns

# Apply Ingress and basic authentication
kubectl apply -f mlflow/ingress-basic-auth-secret.yaml
kubectl apply -f mlflow/mlflow-ingress.yaml
