#!/bin/bash
# author:jack
# date:20171029
# setup kubernetes 
# FILENAME:slave-setup.sh
#########################

if [ -e GLOBAL-ENV ];then
  source GLOBAL-ENV
else
  echo 'File GLOBAL-ENV does not exist.'
  echo -1
fi

# startup docker daemon
cd $HOME_PATH/bin && ./srv.docker

# sleep 10's for startup flannel
sleep 10

# set docker socket
cd $HOME_PATH/bin && ./set-docker

# startup flannel daemon
cd $HOME_PATH/bin && ./srv.flanneld

# sleep 10's for set docker0
sleep 5

# set docker0 
cd $HOME_PATH/bin && ./set-netbridge

# startup srv.kubelet
cd $HOME_PATH/bin && ./srv.kubelet >> $KUBERNETES/client/kubelet/logs/kubelet.log  2>&1 &

# startup srv.kube-proxy
cd $HOME_PATH/bin && ./srv.kube-proxy
