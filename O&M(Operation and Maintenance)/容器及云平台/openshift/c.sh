#!/bin/bash


./openshift start node \
--kubeconfig="/home/blue/bin/openshift.local.config/master/admin.kubeconfig" \
--listen='https://0.0.0.0:28443'
