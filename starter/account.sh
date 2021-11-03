#!/bin/bash -e

for namespace in $(kubectl --kubeconfig kube_config_cluster.yml get namespaces -A -o json | jq -r '.items[].metadata.name'); do
  kubectl --kubeconfig kube_config_cluster.yml patch serviceaccount -n ${namespace} -p "$(cat account_update.yaml)"
done
