
helm repo add falcosecurity https://falcosecurity.github.io/charts

 ssh root@192.168.50.101


rpm --import https://falco.org/repo/falcosecurity-3672BA8F.asc


curl -s -o /etc/zypp/repos.d/falcosecurity.repo https://falco.org/repo/falcosecurity-rpm.repo


Install the kernel headers. This is a key step, where we will apply the SUSE-specific kernel headers prepared by the Falco team in order to intercept syscalls on the SUSE operating system.

zypper -n install kernel-default-devel 



kubectl --kubeconfig kube_config_cluster.yml logs -f falco-2w6wb | grep adduser 
kubectl --kubeconfig kube_config_cluster.yml logs -f falco-2w6wb | grep /etc/shadow
kubectl --kubeconfig kube_config_cluster.yml logs -f falco-2w6wb | grep nc


