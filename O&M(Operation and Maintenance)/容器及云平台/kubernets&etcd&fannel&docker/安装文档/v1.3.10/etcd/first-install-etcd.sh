#!/bin/bash
# author:jack
# date:20171024
# first install etcd service
###########################


if [ -e GLOBAL-ENV ];then
  source GLOBAL-ENV
else
  echo 'File GLOBAL-ENV does not exist.'
  echo -1
fi

ETCD_PATH=$HOME_PATH/apps/etcd


# Set etcd Directory
mkdir -p $HOME_PATH/apps/etcd/{bin,data,wal,logs}

# Decompression etcd-v3.2.9-linux-amd64.tar.gz to $HOME_PATH/apps/etcd/bin
cd $HOME_PATH/src && tar zxvf etcd-v3.2.9-linux-amd64.tar.gz -C $HOME_PATH/apps/etcd/bin/

$ETCD_PATH/bin/etcd \
--name etcd01 \
--data-dir "$ETCD_PATH/data" \
--wal-dir "$ETCD_PATH/wal" \
--snapshot-count 10000 \
--heartbeat-interval 100 \
--election-timeout 1000 \
--listen-peer-urls "http://$LOCAL_IPADDRESS:2380" \
--listen-client-urls "http://0.0.0.0:2379,http://0.0.0.0:4001" \
--max-snapshots 5 \
--max-wals 5 \
--initial-advertise-peer-urls "http://$LOCAL_IPADDRESS:2380" \
--initial-cluster "etcd00=http://$LOCAL_IPADDRESS:2380" \
--initial-cluster-token "etcd-cluster" \
--advertise-client-urls "http://$LOCAL_IPADDRESS:2379,http://$LOCAL_IPADDRESS:4001" \
--force-new-cluster  
   

