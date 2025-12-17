

./cfssl gencert -initca ca-csr.json | ./cfssljson -bare ca
./cfssl gencert -ca=ca.pem -ca-key=ca-key.pem --config=ca-config.json \
	-profile=kubernetes apiserver-csr.json | ./cfssljson -bare kube-apiserver
./cfssl gencert -ca=ca.pem -ca-key=ca-key.pem --config=ca-config.json \
	-profile=kubernetes controller-manager.json | ./cfssljson -bare kube-controller-manager

KUBECONFIG=kube-controller-manager.conf kubectl config set-cluster kubernetes \
	--server=https://127.0.0.1:6443 --certificate-authority ca.pem --embed-certs
KUBECONFIG=kube-controller-manager.conf kubectl config set-credentials system:kube-controller-manager \
	--client-key kube-controller-manager-key.pem --client-certificate kube-controller-manager.pem \
	--embed-certs
KUBECONFIG=kube-controller-manager.conf kubectl config set-context system:kube-controller-manager@kubernetes \
	--cluster kubernetes --user system:kube-controller-manager
KUBECONFIG=kube-controller-manager.conf kubectl config use-context system:kube-controller-manager@kubernetes 

./cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json \
	-profile=kubernetes kube-scheduler-csr.json | ./cfssljson -bare kube-scheduler

KUBECONFIG=kube-scheduler.conf kubectl config set-cluster kubernetes \
	--server=https://127.0.0.1:6443 --certificate-authority ca.pem --embed-certs
KUBECONFIG=kube-scheduler.conf kubectl config set-credentials system:kube-scheduler \
	--client-key kube-scheduler-key.pem --client-certificate kube-scheduler.pem --embed-certs
KUBECONFIG=kube-scheduler.conf kubectl config set-context system:kube-scheduler@kubernetes \
	--cluster kubernetes --user system:kube-scheduler
KUBECONFIG=kube-scheduler.conf kubectl config use-context system:kube-scheduler@kubernetes


./cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json \
	-profile=kubernetes admin-csr.json | ./cfssljson -bare admin

KUBECONFIG=admin.kubeconfig kubectl config set-cluster kubernetes \
	--server=https://127.0.0.1:6443 --certificate-authority ca.pem --embed-certs
KUBECONFIG=admin.kubeconfig kubectl config set-credentials admin \
	--client-key admin-key.pem --client-certificate admin.pem --embed-certs
KUBECONFIG=admin.kubeconfig kubectl config set-context default  \
	--cluster kubernetes --user admin
KUBECONFIG=admin.kubeconfig kubectl config use-context default

