#!/bin/bash
# author:jack
# date:20171029
# setup kubernetes 
# FILENAME:master-install.sh
#########################

if [ -e GLOBAL-ENV ];then
  source GLOBAL-ENV
else
  echo 'File GLOBAL-ENV does not exist.'
  echo -1
fi


# Decompression master.tar.gz to be used k8s master 
if [ -e $HOME_PATH/src/master.tar.gz ];then
  cd $HOME_PATH/src && tar zxvf $HOME_PATH/src/master.tar.gz 
else 
  echo "Flle $HOME_PATH/src/master.tar.gz does not exist."
  exit -1
fi


# Setup kubernetes Directory
mkdir -p $HOME_PATH/apps/kubernetes/server/logs
mkdir -p $HOME_PATH/apps/kubernetes/server/var/run/kubernetes
mkdir -p $HOME_PATH/apps/kubernetes/server/bin


# Move kube-dns,kube-apiserver,kube-controller-manager,kube-scheduler to 
# $HOME_PATH/apps/kubernetes/server/bin
cd $HOME_PATH/src/master && mv kube-apiserver kube-controller-manager kube-dns kube-scheduler $HOME_PATH/apps/kubernetes/server/bin/ 

# Move srv.kube-apiserver,srv.kube-controller-manager,srv.kube-scheduler to $HOME_PATH/bin/
cd $HOME_PATH/src/master && mv srv.kube-apiserver srv.kube-controller-manager srv.kube-scheduler $HOME_PATH/bin/

# Change Directory's Owner
chown -R $USERNAME:$USERNAME /home/$USERNAME/* 




