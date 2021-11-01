docker run --pid=host -v /etc:/node/etc:ro -v /var:/node/var:ro -ti rancher/security-scan:v0.2.2 bash


kube-bench run --targets etcd,master,controlplane,policies --scored --config-dir=/etc/kube-bench/cfg --benchmark rke-cis-1.6-hardened | grep FAIL

kube-bench run --targets etcd,master,controlplane,policies --scored --config-dir=/etc/kube-bench/cfg --benchmark rke-cis-1.6-permissive

docker run --pid=host -v /etc:/node/etc:ro -v /var:/node/var:ro -ti rancher/security-scan:v0.2.2 bash
kube-bench run --targets etcd,master,controlplane,policies --scored --config-dir=/etc/kube-bench/cfg --benchmark rke-cis-1.6-hardened | grep FAIL


1.1.12 Ensure that etcd data directory ownership is set to etcd:etcd (scored)




In the previous demo we ran Kube-bench on node1, an RKE etcd,master,controlplane,policies node. In this demo, we will run Kube-bench on node2, a worker node.

Run Kube-bench on Worker Node Using Permissive and Hardened Profile
Bring up the worker node2 via ssh root@192.168.50.102. The password is vagrant.
Start up the rancher/security-scan:v0.2.2 container via docker run --pid=host -v /etc:/node/etc:ro -v /var:/node/var:ro -ti rancher/security-scan:v0.2.2 bash
Within the container context, run the Kube-bench scan against node2 all components using the rke-cis-1.6-permissivebenchmark profile via kube-bench run --targets node --scored --config-dir=/etc/kube-bench/cfg --benchmark rke-cis-1.6-permissive
Now try the rke-cis-1.6-hardened benchmark profile via kube-bench run --targets node --scored --config-dir=/etc/kube-bench/cfg --benchmark rke-cis-1.6-hardened
Notice how only 0 checks FAIL with either hardened or permissive profile. This is because the Rancher team has gone to great lengths to harden the worker node.
