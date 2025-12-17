#!/bin/bash

/home/blue/bin/openshift start master \
--etcd='http://127.0.0.1:4001' \
--expire-days=730 \
--host-subnet-length=9 \
--images='openshift/origin-${component}:${version}' \
--latest-images=false \
--listen='https://0.0.0.0:18443' \
--master='https://localhost:18443' \
--network-cidr='10.128.0.0/14' \
--portal-net='172.30.0.0/16' \
--public-master='https://localhost:18443' \
--signer-expire-days=1825

#--etcd-dir='openshift.local.etcd' \

