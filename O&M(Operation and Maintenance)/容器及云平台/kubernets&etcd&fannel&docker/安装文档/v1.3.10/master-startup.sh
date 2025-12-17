#!/bin/bash
# author:jack
# date:20171029
# setup kubernetes 
# FILENAME:master-setup.sh
#########################

if [ -e GLOBAL-ENV ];then
  source GLOBAL-ENV
else
  echo 'File GLOBAL-ENV does not exist.'
  echo -1
fi

# startup srv.kube-apiserver
cd $HOME_PATH/bin && ./srv.kube-apiserver

# startup srv.kube-controller-manager
cd $HOME_PATH/bin && ./srv.kube-controller-manager

# startup srv.kube-scheduler
cd $HOME_PATH/bin && ./srv.kube-scheduler

# startup srv.kube-dns 
cd $HOME_PATH/bin && ./srv.kube-dns
