#!/bin/bash


#./openshift start node --enable='kubelet' --kubeconfig="openshift.local.config/master/admin.kubeconfig"  >> 1.log 2>&1 &
./openshift start node  --disable='dns' --enable='kubelet' --kubeconfig="openshift.local.config/master/master-config.yaml"  >> 1.log 2>&1 &
