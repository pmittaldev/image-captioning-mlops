#!/bin/bash

# Uninstall Helm releases
helm uninstall postgresql --namespace mlflow-ns
helm uninstall mlflow --namespace mlflow-ns

# Delete secrets
kubectl delete secret postgres-credentials --namespace mlflow-ns
kubectl delete secret gcs-credentials --namespace mlflow-ns
kubectl delete secret mlflow-basic-auth --namespace mlflow-ns

# Delete persistent volume claims
kubectl delete pvc -l app.kubernetes.io/name=postgresql --namespace mlflow-ns

# Delete Ingress
kubectl delete -f mlflow/mlflow-ingress.yaml

# Optional: Delete namespace
kubectl delete namespace mlflow-ns
