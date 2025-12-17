Red Hat OpenShift容器平台版本3.5（RHBA-2017：0884）现已推出。此版本基于OpenShift Origin 1.5。本主题包含与OpenShift Container Platform 3.5有关的新功能，更改，错误修复以及已知问题。

OpenShift容器平台3.5在RHEL 7.2和7.3中得到了Extras的最新软件包的支持，其中包括Docker 1.12。


每个群集的最大节点数
1000
每个群集的最大pod
120000
每个节点的最大pod
250
每个核心的最大荚数
10


k8s-ovs

$ etcdctl set /k8s.ovs.com/ovs/network/config '{"Name":"k8ssdn", "Network":"172.11.0.0/16", "HostSubnetLength":10, "ServiceNetwork":"10.96.0.0/12", "PluginName":"k8s-ovs-multitenant"}'

$ /usr/sbin/k8s-ovs --etcd-endpoints=http://${etcd_ip}:2379 --etcd-prefix=/k8s.ovs.com/ovs/network --alsologtostderr --v=5


wget -c -r -np http://hk.archive.ubuntu.com/ubuntu/dists/zesty-backports/main/i18n -e use_proxy=yes -e http_proxy=http://proxy.bmcc.com.cn:8080


cp -Rf a/jack b/jack  #将合并a/jack到b/jack中

openshift orign下载
https://github.com/openshift/origin
https://github.com/openshift/origin/releases


ubuntu 使用光盘作为源
mount /dev/sr0 /mnt

修改/etc/apt/source.list，如下
deb file:///mnt zesty main restricted



apt-get install python-yaml
apt-get install python-setuptools


删除包
apt-get remove ntp
清除所有已删除包的残馀配置文件 
dpkg -l |grep ^rc|awk '{print $2}' |sudo xargs dpkg -P 



10.224.227.80  /home/iso



libexpat1 libexpat1-dev libpython-dev libpython2.7 libpython2.7-dev python2.7-dev


libexpat1-dev libpython-dev libpython2.7 libpython2.7-dev python-dev python2.7-dev



etcd 2379 2380 4001




apt-get install openvswitch-switch


/usr/local/bin/etcd \
--name etcd00 \
--data-dir '$HOME/apps/etcd/data' \
--wal-dir '/home/blue/apps/etcd/wal' \
  --initial-advertise-peer-urls http://${address}:2380 \
  --listen-peer-urls http://${address}:2380 \
  --advertise-client-urls http://${address}:2379 \
  --listen-client-urls http://127.0.0.1:2379,http://${address}:2379 \
--initial-cluster 'etcd00=http://192.168.81.3:2380,etcd02=http://192.168.81.5:2380,etcd03=http://192.168.81.6:2380' \ 
--initial-cluster-token 'etcd-cluster' \
--initial-cluster-state 'existing'  >> $HOME/apps/etcd/log/etcd.log 2>&1 &



容器启动时添加子网
--insecure-registry 172.30.0.0/16


1.etcd
2.glusterFS



kubelet: error: failed to run Kubelet: failed to create kubelet: misconfiguration: kubelet cgroup driver: "cgroupfs" is different from docker cgroup driver: "systemd"
解决：
在docker启动时候，指定
--exec-opt native.cgroupdriver=systemd



master的启动相当诡异，没有网关，会提示不能绑定本地地址












