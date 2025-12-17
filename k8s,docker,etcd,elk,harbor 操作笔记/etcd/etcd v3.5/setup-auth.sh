#!/bin/bash
set -x
set -e

./cfssl gencert -initca ca-csr.json | ./cfssljson -bare ca -
./cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json \
	-profile=server server.json | ./cfssljson -bare server
./cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json \
	-profile=peer etcd1.json | ./cfssljson -bare etcd1
./cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json \
	-profile=peer etcd2.json | ./cfssljson -bare etcd2
./cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json \
	-profile=peer etcd3.json | ./cfssljson -bare etcd3

./cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json \
	-profile=client client.json | ./cfssljson -bare client
