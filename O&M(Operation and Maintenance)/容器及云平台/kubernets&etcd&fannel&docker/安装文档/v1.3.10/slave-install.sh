#!/bin/bash
# author:jack
# date:20171029
# setup kubernetes 
# execute with ROOT user
# FILENAME:slave-install.sh
#########################

if [ -e GLOBAL-ENV ];then
  source GLOBAL-ENV
else
  echo 'File GLOBAL-ENV does not exist.'
  echo -1
fi

# Decompression slave.tar.gz to be used k8s master 
if [ -e $HOME_PATH/src/slave.tar.gz ];then
  cd $HOME_PATH/src && tar zxvf $HOME_PATH/src/slave.tar.gz 
else 
  echo "Flle $HOME_PATH/src/slave.tar.gz does not exist."
  exit -1
fi


# Setup docker-1.12.0 Directory
mkdir -p $HOME_PATH/apps/docker/var/run/
mkdir -p $HOME_PATH/apps/docker/var/lib/
mkdir -p $HOME_PATH/apps/docker/logs
touch $HOME_PATH/apps/docker/logs/docker.log

# Move docker* to /usr/bin
cd $HOME_PATH/src/slave && mv docker* /usr/bin/

# Move srv.docker to $HOME_PATH/bin
cd $HOME_PATH/src/slave && mv srv.docker $HOME_PATH/bin/


# Setup flannel0.9.0 Directory 
mkdir -p $HOME_PATH/apps/flannel/bin

# Move flannel,mk-docker-opts.sh to $HOME_PATH/apps/flannel/bin
cd $HOME_PATH/src/slave && mv flanneld mk-docker-opts.sh $HOME_PATH/apps/flannel/bin

# Move srv.flanneld to $HOME_PATH/bin/ 
cd $HOME_PATH/src/slave && mv srv.flanneld $HOME_PATH/bin/


# Setup kubelet Directory
mkdir -p $HOME_PATH/apps/kubernetes/client/kubelet/{bin,etc,logs,plugins,pods,seccomp,var}
mkdir -p $HOME_PATH/apps/kubernetes/client/kubelet/var/run/kubernetes
touch $HOME_PATH/apps/kubernetes/client/kubelet/etc/kubeconfig
touch $HOME_PATH/apps/kubernetes/client/kubelet/etc/machine-id

# Move kubelet to $HOME_PATH/apps/kubernetes/client/kubelet/bin
cd $HOME_PATH/src/slave && mv kubelet $HOME_PATH/apps/kubernetes/client/kubelet/bin

# Move srv.kubelet to $HOME_PATH/bin/
cd $HOME_PATH/src/slave && mv srv.kubelet $HOME_PATH/bin/


# Setup kube-proxy Directory
mkdir -p $HOME_PATH/apps/kubernetes/client/kube-proxy/{bin,etc,logs}
touch $HOME_PATH/apps/kubernetes/client/kube-proxy/etc/kubeconfig

# Move kube-proxy to $HOME_PATH/apps/kubernetes/client/kube-proxy/bin
cd $HOME_PATH/src/slave && mv kube-proxy $HOME_PATH/apps/kubernetes/client/kube-proxy/bin/

# Move srv.kube-proxy to $HOME_PATH/bin/
cd $HOME_PATH/src/slave && mv srv.kube-proxy $HOME_PATH/bin/

# Change Directory's Owner
chown -R $USERNAME:$USERNAME /home/$USERNAME/* 




