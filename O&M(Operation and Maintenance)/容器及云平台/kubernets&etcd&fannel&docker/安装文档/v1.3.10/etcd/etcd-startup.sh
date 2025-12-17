#!/bin/bash
# author:jack
# date:20171029
# setup kubernetes 
# FILENAME:etcd-startup.sh
#########################

if [ -e GLOBAL-ENV ];then
  source GLOBAL-ENV
else
  echo 'File GLOBAL-ENV does not exist.'
  echo -1
fi

# startup srv.kube-apiserver
cd $HOME_PATH/bin && nohup ./srv.etcd >> $HOME_PATH/apps/etcd/logs/etcd.log 2>&1 &

