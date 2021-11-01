k3s server \
    --protect-kernel-defaults=true \
    --secrets-encryption=true \
    --kube-apiserver-arg='audit-log-path=/var/lib/rancher/k3s/server/logs/audit-log' \
    --kube-apiserver-arg='audit-log-maxage=30' \
    --kube-apiserver-arg='audit-log-maxbackup=10' \
    --kube-apiserver-arg='audit-log-maxsize=100' \
    --kube-apiserver-arg='request-timeout=300s' \
    --kube-apiserver-arg='service-account-lookup=true' \
    --kube-apiserver-arg='enable-admission-plugins=NodeRestriction,PodSecurityPolicy,NamespaceLifecycle,ServiceAccount' \
    --kube-controller-manager-arg='terminated-pod-gc-threshold=10' \
    --kube-controller-manager-arg='use-service-account-credentials=true' \
    --kubelet-arg='streaming-connection-idle-timeout=5m' \
    --kubelet-arg='make-iptables-util-chains=true'




k3d cluster start k3d-oyelowo-cluster \
    --k3s-arg "--protect-kernel-defaults=true" \
    --k3s-arg "--secrets-encryption=true" \
    --k3s-arg "--kube-apiserver-arg='audit-log-path=/var/lib/rancher/k3s/server/logs/audit-log'" \
    --k3s-arg "--kube-apiserver-arg='audit-log-maxage=30'" \
    --k3s-arg "--kube-apiserver-arg='audit-log-maxbackup=10'" \
    --k3s-arg "--kube-apiserver-arg='audit-log-maxsize=100'" \
    --k3s-arg "--kube-apiserver-arg='request-timeout=300s'" \
    --k3s-arg "--kube-apiserver-arg='service-account-lookup=true'" \
    --k3s-arg "--kube-apiserver-arg='enable-admission-plugins=NodeRestriction,PodSecurityPolicy,NamespaceLifecycle,ServiceAccount'" \
    --k3s-arg "--kube-controller-manager-arg='terminated-pod-gc-threshold=10'" \
    --k3s-arg "--kube-controller-manager-arg='use-service-account-credentials=true'" \
    --k3s-arg "--kubelet-arg='streaming-connection-idle-timeout=5m'" \
    --k3s-arg "--kubelet-arg='make-iptables-util-chains=true'"

k3d cluster create oyelowo-cluster-new \
    --k3s-arg "--protect-kernel-defaults=true@server:*" \
    --k3s-arg "--secrets-encryption=true@server:*" \
    --k3s-arg "--kube-apiserver-arg=audit-log-path=/var/lib/rancher/k3s/server/logs/audit-log@server:*" \
    --k3s-arg "--kube-apiserver-arg=audit-log-maxage=30@server:*" \
    --k3s-arg "--kube-apiserver-arg=audit-log-maxbackup=10@server:*" \
    --k3s-arg "--kube-apiserver-arg=audit-log-maxsize=100@server:*" \
    --k3s-arg "--kube-apiserver-arg=request-timeout=300s@server:*" \
    --k3s-arg "--kube-apiserver-arg=service-account-lookup=true@server:*" \
    --k3s-arg "--kube-apiserver-arg=enable-admission-plugins=NodeRestriction,PodSecurityPolicy,NamespaceLifecycle,ServiceAccount@server:*" \
    --k3s-arg "--kube-controller-manager-arg=terminated-pod-gc-threshold=10@server:*" \
    --k3s-arg "--kube-controller-manager-arg=use-service-account-credentials=true@server:*" \
    --k3s-arg "--kubelet-arg=streaming-connection-idle-timeout=5m@server:*" \
    --k3s-arg "--kubelet-arg=make-iptables-util-chains=true@server:*"

    # --k3s-arg "--protect-kernel-defaults=true@server:*" \
    # --k3s-arg "--secrets-encryption=true@server:*" \
k3d cluster create oyelowo-cluster2 \
    --k3s-arg "--protect-kernel-defaults=true@server:*" \
    --k3s-arg "--secrets-encryption=true@server:*" \
    --k3s-arg "--kube-apiserver-arg='audit-log-path=/var/lib/rancher/k3s/server/logs/audit-log@server:*'" \
    --k3s-arg "--kube-apiserver-arg='audit-log-maxage=30@server:*'" \
    --k3s-arg "--kube-apiserver-arg='audit-log-maxbackup=10@server:*'" \
    --k3s-arg "--kube-apiserver-arg='audit-log-maxsize=100@server:*'" \
    --k3s-arg "--kube-apiserver-arg='request-timeout=300s@server:*'" \
    --k3s-arg "--kube-apiserver-arg='service-account-lookup=true@server:*'" \
    --k3s-arg "--kube-apiserver-arg='enable-admission-plugins=NodeRestriction,PodSecurityPolicy,NamespaceLifecycle,ServiceAccount@server:*'" \
    --k3s-arg "--kube-controller-manager-arg='terminated-pod-gc-threshold=10@server:*'" \
    --k3s-arg "--kube-controller-manager-arg='use-service-account-credentials=true@server:*'" \
    --k3s-arg "--kubelet-arg='streaming-connection-idle-timeout=5m@server:*'" \
    --k3s-arg "--kubelet-arg='make-iptables-util-chains=true@server:*'"


k3d cluster create oye-cluster \
    --k3s-arg "--protect-kernel-defaults=true@server:*" \
    --k3s-arg "--secrets-encryption=true@server:*" \
    --k3s-arg "--kube-apiserver-arg=audit-log-path=/var/lib/rancher/k3s/server/logs/audit-log@server:*" \
    --k3s-arg "--kube-apiserver-arg=audit-log-maxage=30@server:*" \
    --k3s-arg "--kube-apiserver-arg=audit-log-maxbackup=10@server:*" \
    --k3s-arg "--kube-apiserver-arg=audit-log-maxsize=100@server:*" \
    --k3s-arg "--kube-apiserver-arg=request-timeout=300s@server:*" \
    --k3s-arg "--kube-apiserver-arg=service-account-lookup=true@server:*" \
    --k3s-arg "--kube-apiserver-arg=enable-admission-plugins=NodeRestriction,PodSecurityPolicy,NamespaceLifecycle,ServiceAccount@server:*" \
    --k3s-arg "--kube-controller-manager-arg=terminated-pod-gc-threshold=10@server:*" \
    --k3s-arg "--kube-controller-manager-arg=use-service-account-credentials=true@server:*" \
    --k3s-arg "--kubelet-arg=streaming-connection-idle-timeout=5m@server:*" \
    --k3s-arg "--kubelet-arg=make-iptables-util-chains=true@server:*"


k3s server \
    --protect-kernel-defaults=true \
    --secrets-encryption=true \
    --kube-apiserver-arg='audit-log-path=/var/lib/rancher/k3s/server/logs/audit-log' \
    --kube-apiserver-arg='audit-log-maxage=30' \
    --kube-apiserver-arg='audit-log-maxbackup=10' \
    --kube-apiserver-arg='audit-log-maxsize=100' \
    --kube-apiserver-arg='request-timeout=300s' \
    --kube-apiserver-arg='service-account-lookup=true' \
    --kube-apiserver-arg='enable-admission-plugins=NodeRestriction,PodSecurityPolicy,NamespaceLifecycle,ServiceAccount' \
    --kube-controller-manager-arg='terminated-pod-gc-threshold=10' \
    --kube-controller-manager-arg='use-service-account-credentials=true' \
    --kubelet-arg='streaming-connection-idle-timeout=5m' \
    --kubelet-arg='make-iptables-util-chains=true'
    
curl -sfL https://get.k3s.io | sh -s - \
    --protect-kernel-defaults=true \
    --secrets-encryption=true \
    --kube-apiserver-arg='audit-log-path=/var/lib/rancher/k3s/server/logs/audit-log' \
    --kube-apiserver-arg='audit-log-maxage=30' \
    --kube-apiserver-arg='audit-log-maxbackup=10' \
    --kube-apiserver-arg='audit-log-maxsize=100' \
    --kube-apiserver-arg='request-timeout=300s' \
    --kube-apiserver-arg='service-account-lookup=true' \
    --kube-apiserver-arg='enable-admission-plugins=NodeRestriction,PodSecurityPolicy,NamespaceLifecycle,ServiceAccount' \
    --kube-controller-manager-arg='terminated-pod-gc-threshold=10' \
    --kube-controller-manager-arg='use-service-account-credentials=true' \
    --kubelet-arg='streaming-connection-idle-timeout=5m' \
    --kubelet-arg='make-iptables-util-chains=true'

curl -sfL https://get.k3s.io | sh -s - \
    --protect-kernel-defaults=true \
    --secrets-encryption=true \
    --kube-apiserver-arg='audit-log-path=/var/lib/rancher/k3s/server/logs/audit-log' \
    --kube-apiserver-arg='audit-log-maxage=30' \
    --kube-apiserver-arg='audit-log-maxbackup=10' \
    --kube-apiserver-arg='audit-log-maxsize=100' \
    --kube-apiserver-arg='request-timeout=300s' \
    --kube-apiserver-arg='service-account-lookup=true' \
    --kube-apiserver-arg='enable-admission-plugins=NodeRestriction,PodSecurityPolicy,NamespaceLifecycle,ServiceAccount' \
    --kube-controller-manager-arg='terminated-pod-gc-threshold=10' \
    --kube-controller-manager-arg='use-service-account-credentials=true' \
    --kubelet-arg='streaming-connection-idle-timeout=5m' \
    --kube-apiserver-arg='make-iptables-util-chains=true'

curl -sfL https://get.k3s.io | sh -


touch /var/lib/rancher/k3s/server/manifests/policy.yaml
vi /var/lib/rancher/k3s/server/manifests/policy.yaml
kubectl apply -f /var/lib/rancher/k3s/server/manifests/policy.yaml

kubectl apply -f /var/lib/rancher/k3s/server/manifests
kubectl apply -f job.yaml -n kube-system
kubectl get po -A

kubectl logs kube-bench-wk45b
kubectl logs kube-bench-wk45b -n kube-system | grep FAIL
kubectl logs kube-bench-m8f9k | grep FAIL

/usr/local/bin/k3s-uninstall.sh

/etc/sysctl.d
touch /etc/sysctl.d/90-kubelet.conf




kube-bench run --targets master,controlplane,policies --scored --config-dir=/etc/kube-bench/cfg --benchmark rke-cis-1.6-hardened



kube-bench run --targets master,controlplane,policies --scored --config-dir=/etc/kube-bench/cfg --benchmark rke-cis-1.6-hardened | grep FAIL
kube-bench run --targets etcd,master,controlplane,policies --scored --config-dir=/etc/kube-bench/cfg --benchmark rke-cis-1.6-hardened | grep FAIL


,nodefs.available=1%@agent:
k3d cluster create k3d-one \
  --k3s-arg "--cluster-cidr=10.118.0.0/17@server:*" \
  --k3s-arg "--service-cidr=10.118.128.0/17@server:*" \
  --k3s-arg "--disable=servicelb@server:*" \
  --k3s-arg "--disable=traefik@server:*" \
  --verbose


echo EOF<<

EOF>>




psp:restricted


kubectl-admin create rolebinding default:psp:restricted \
    --role=psp:restricted \
    --serviceaccount=psp-example:default



kubectl create role psp:restricted \
    --verb=use \
    --resource=podsecuritypolicy \
    --resource-name=cis1.5-compliant-psp
# role "psp:restricted" created


kubectl create rolebinding default:psp:restricted \
    --role=psp:restricted \
    --serviceaccount=psp-example:default
