helm repo add stable https://charts.helm.sh/stable

helm install --kubeconfig kube_config_cluster.yml stable/prometheus-operator --generate-name


kubectl --kubeconfig kube_config_cluster.yml --namespace default get pods -l "release=prometheus-operator-1619828194"


kubectl --kubeconfig kube_config_cluster.yml --namespace default get pods | grep prometheus


kubectl --kubeconfig kube_config_cluster.yml --namespace default port-forward prometheus-prometheus-operator-[   ]-prometheus-0 9090


If Prometheus doesn't come up as expected, you need to run the following command to kill any existing port forwarding:
lsof -ti:9090 | xargs kill -9



# Falco exporter

helm install --kubeconfig kube_config_cluster.yml falco-exporter \
 --set serviceMonitor.enabled=true \
falcosecurity/falco-exporter



xport POD_NAME=$(
kubectl get pods --namespace default -l "app.kubernetes.io/name=falco-exporter,app.kubernetes.io/instance=falco-exporter" -o jsonpath="{.items[0].metadata.name}")



kubectl --kubeconfig kube_config_cluster.yml get pods --namespace default -l "app.kubernetes.io/name=falco-exporter,app.kubernetes.io/instance=falco-exporter" -o jsonpath="{.items[0].metadata.name}"
falco-exporter-f4z44
"Visit http://127.0.0.1:9376/metrics to use your application"



kubectl --kubeconfig kube_config_cluster.yml port-forward --namespace default falco-exporter-[   ] 9376



# Create service monitor
touch falco_service_monitor.yaml

```yaml
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  labels:
  ## Change this to what is in my local environment
    release: prometheus-operator-1619828194
  name: falco-exporter-servicemonitor
  namespace: default
spec:
  endpoints:
  - bearerTokenFile: /var/run/secrets/kubernetes.io/serviceaccount/token
  - port: metrics 
    interval: 5s
  namespaceSelector:
    matchNames:
    - default
  selector:
    matchLabels:
      app.kubernetes.io/instance: falco-exporter
      app.kubernetes.io/name: falco-exporter
```

## Check Prometheus release:

helm repo add stable https://charts.helm.sh/stable

helm install --kubeconfig kube_config_cluster.yml stable/prometheus-operator --generate-name


kubectl --kubeconfig kube_config_cluster.yml --namespace default get pods -l "release=prometheus-operator-1635887444"

kubectl --kubeconfig kube_config_cluster.yml --namespace default get pods | grep prometheus


kubectl --kubeconfig kube_config_cluster.yml --namespace default port-forward prometheus-prometheus-operator-163588-prometheus-0 9090





helm install --kubeconfig kube_config_cluster.yml falco-exporter \
 --set serviceMonitor.enabled=true \
falcosecurity/falco-exporter


kubectl --kubeconfig kube_config_cluster.yml get pod -o wide

```sh
# kubectl --kubeconfig kube_config_cluster.yml port-forward --namespace default falco-exporter-[   ] 9376
kubectl --kubeconfig kube_config_cluster.yml port-forward --namespace default falco-exporter-6klgt 9376
# http://127.0.0.1:9376/metrics
```




kubectl --kubeconfig kube_config_cluster.yml --namespace default port-forward prometheus-operator-1635887444-grafana-6c47fcc984-ckkq2 3000







kubectl --kubeconfig kube_config_cluster.yml get prometheus

kubectl --kubeconfig kube_config_cluster.yml --namespace default get pods | grep prometheus



kubectl --kubeconfig kube_config_cluster.yml edit prometheus prometheus-operator-161982-prometheus

kubectl --kubeconfig kube_config_cluster.yml --namespace default get pods -l "release=prometheus-operator-163588-prometheus"



kubectl --kubeconfig kube_config_cluster.yml apply -f falco_service_monitor.yaml



kubectl --kubeconfig kube_config_cluster.yml get pod



kubectl --kubeconfig kube_config_cluster.yml --namespace default port-forward prometheus-operator-1619828194-grafana-79668b6f49-j964r 3000


Browse http://127.0.0.1:3000/ from your web browser and login using the following information:

Username: admin
Password: prom-operator
