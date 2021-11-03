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

GuestAdditions are newer than your host but, downgrades are disabled. Skipping.




kubectl --kubeconfig kube_config_cluster.yml get nodes
kubectl --kubeconfig kube_config_cluster.yml get pods -A  




kube-bench run --targets etcd,master,controlplane,policies --scored --config-dir=/etc/kube-bench/cfg --benchmark rke-cis-1.6-permissive


kube-bench run --targets etcd,master,controlplane,policies --scored --config-dir=/etc/kube-bench/cfg --benchmark rke-cis-1.6-permissive | grep FAIL


kube-bench run --targets etcd,master,controlplane,policies --scored --config-dir=/etc/kube-bench/cfg --benchmark rke-cis-1.6-hardened | grep FAIL




HELM

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3


chmod 700 get_helm.sh


./get_helm.sh 


version.BuildInfo{Version:"v3.5.4", GitCommit:"1b5edb69df3d3a08df77c9902dc17af864ff05d1", GitTreeState:"clean", GoVersion:"go1.15.11"}



Note: You should install the latest version of Helm. Refer to this page for the latest version.

Next, we need to add the falcosecurity repo using a Helm chart. Helm charts are ways to package applications for Kubernetes native environments. We add the falcosecurity repo in order to stage it locally:

helm repo add falcosecurity https://falcosecurity.github.io/charts
We then need to install special Falco drivers and kernel headers before installing Falco itself. Falco uses either a kernel module driver (also known as kmod) or an extended Berkeley Packet Filter (eBPF) driver in order to intercept syscalls and process them from a security perspective. We need to make sure the drivers are in place so that Falco can intercept syscalls to the kernel. Here are the steps to install Falco drivers and kernel headers:

SSH into node1 and install the driver. Password is vagrant.
 ssh root@192.168.50.101
Download the falcosecurity-3672BA8F.asc file, which is a checksum for the drivers. Trust the falcosecurity GPG (GNU Privacy Guard) key:
rpm --import https://falco.org/repo/falcosecurity-3672BA8F.asc
Next, we will curl and configure the zypper repository that contains the drivers:
curl -s -o /etc/zypp/repos.d/falcosecurity.repo https://falco.org/repo/falcosecurity-rpm.repo
Note: /etc/zypp/repos.d/falcosecurity.repo is the name of the repo. https://falco.org/repo/falcosecurity-rpm.repo is the location of the repo.

Install the kernel headers. This is a key step, where we will apply the SUSE-specific kernel headers prepared by the Falco team in order to intercept syscalls on the SUSE operating system.
zypper -n install kernel-default-devel 
Note: The installation will take about 5 minutes. The version should be something close to 5.3.18, specifically for the x86 64-bit operating system that SUSE runs.

It is important to reboot node1 once the installation is complete.



