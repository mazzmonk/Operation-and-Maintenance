#!/bin/bash


./openshift start node --enable='plugins' --network-plugin='redhat/openshift-ovs-subnet' --kubeconfig="openshift.local.config/master/admin.kubeconfig" >> 2.log 2>&1 &
