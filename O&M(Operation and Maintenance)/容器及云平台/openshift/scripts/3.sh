#!/bin/bash

#./openshift start node --enable='kubelet,plugins,proxy' --kubeconfig="openshift.local.config/master/admin.kubeconfig" --network-plugin='redhat/openshift-ovs-subnet' --expire-days=730 >>log.log 2>&1
#./openshift start node --enable='plugins' --kubeconfig="openshift.local.config/master/admin.kubeconfig" --network-plugin='redhat/openshift-ovs-subnet' --expire-days=730 

#./openshift start node --enable='kubelet' --kubeconfig="openshift.local.config/master/admin.kubeconfig" --network-plugin='redhat/openshift-ovs-subnet' --expire-days=730 
#./openshift start node --enable='plugins' --kubeconfig="openshift.local.config/master/admin.kubeconfig" --network-plugin='redhat/openshift-ovs-subnet' --expire-days=730 
./openshift start node --enable='proxy' --kubeconfig="openshift.local.config/master/admin.kubeconfig" >> 3.log 2>&1 & 

