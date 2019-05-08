#!/bin/bash

sudo yum -y update
sudo yum install -y yum-utils device-mapper-persistent-data lvm2 curl wget ntp
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
wget https://download.docker.com/linux/centos/gpg | sudo yum add -
sudo yum install -y docker-ce docker-ce-cli
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker vagrant


echo "**** Begin installing kubectl"

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
yum install -y kubectl

#Check the kubectl configuration
kubectl cluster-info

echo "**** End installing kubectl"


wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 -P /home/vagrant
sudo mv /home/vagrant/minikube-linux-amd64 /home/vagrant/minikube
sudo chmod +x /home/vagrant/minikube
sudo cp /home/vagrant/minikube /usr/local/bin
rm /home/vagrant/minikube
minikube start --vm-driver=none

#Running the setup

kubectl apply -f /vagrant/multicontainer.yaml