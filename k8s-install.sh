## User data for master and worker nodes
#!/bin/bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt update && sudo apt install kubelet kubeadm kubectl kubernetes-cni docker.io -y
sudo -i
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
apt update && apt install -y containerd.io
rm /etc/containerd/config.toml
systemctl restart containerd

## Aditional step to be taken after installation on master node
# run "sudo su"
# run "export MASTER_IP=<IP-of-Node>"
# run "kubeadm init --apiserver-advertise-address=${MASTER_IP} --pod-network-cidr=10.244.0.0/16"

## Steps to be taken on worker node
# run "sudo su"
# run the generated "kubeadm join" command string of master node into worker node

## Again run the following commands in master node
# run "exit" to exit root
# run "export KUBECONFIG=/etc/kubernetes/admin.conf"
# run "sudo chmod 777 /etc/kubernetes/admin.conf"
# run "kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml"

## Recent issue (Fixed 19/01/2023)
# https://github.com/containerd/containerd/issues/4581
