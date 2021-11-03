#!/bin/bash
#start monero_cpu_moneropool
kubectl run --kubeconfig kube_config_cluster.yml moneropool --image=servethehome/monero_cpu_moneropool:latest r 1
#start minergate
kubectl run --kubeconfig kube_config_cluster.yml minergate --image=servethehome/monero_cpu_minergate:latest r 1
#start cryptotonight
kubectl run --kubeconfig kube_config_cluster.yml cryptonight --image=servethehome/universal_cryptonight:latest r 1

echo "Can you identify the payload(s)?"
