#!/bin/bash
# author:jack
# date:20171029
# setup OS kernel and etc.
# execute with ROOT user
############################

sed -i '$a net.core.wmem_default = 8388608'  /etc/sysctl.conf
sed -i '$a net.core.wmem_max = 16777216'  /etc/sysctl.conf
sed -i '$a net.core.rmem_default = 8388608'  /etc/sysctl.conf
sed -i '$a net.core.rmem_max = 16777216'  /etc/sysctl.conf
sed -i '$a net.core.netdev_max_backlog = 262144'  /etc/sysctl.conf

sed -i '$a net.ipv4.tcp_max_orphans = 3276800'  /etc/sysctl.conf
sed -i '$a net.ipv4.tcp_max_syn_backlog = 262144'  /etc/sysctl.conf
sed -i '$a net.ipv4.tcp_timestamps = 0'  /etc/sysctl.conf
sed -i '$a net.ipv4.tcp_synack_retries = 1'  /etc/sysctl.conf
sed -i '$a net.ipv4.tcp_syn_retries = 1'  /etc/sysctl.conf
sed -i '$a net.ipv4.tcp_tw_recycle = 1'  /etc/sysctl.conf
sed -i '$a net.ipv4.tcp_tw_reuse = 1'  /etc/sysctl.conf
sed -i '$a net.ipv4.tcp_mem = 94500000 915000000 927000000'  /etc/sysctl.conf
sed -i '$a net.ipv4.tcp_fin_timeout = 1'  /etc/sysctl.conf
sed -i '$a net.ipv4.tcp_keepalive_time = 30'  /etc/sysctl.conf
sed -i '$a net.ipv4.ip_forward = 1' /etc/sysctl.conf


sed -i '$a /usr/lib' /etc/ld.so.conf
sed -i '$a /usr/lib64' /etc/ld.so.conf
sed -i '$a /lib' /etc/ld.so.conf
sed -i '$a /lib64' /etc/ld.so.conf

ldconfig

sed -i '$a \\' /etc/security/limits.conf
sed -i '$a * soft nproc 65535' /etc/security/limits.conf
sed -i '$a * hard nproc 65535' /etc/security/limits.conf
sed -i '$a * soft nofile 65535' /etc/security/limits.conf
sed -i '$a * hard nofile 65535' /etc/security/limits.conf


cp /etc/locale.conf /etc/locale.conf.default
echo " " > /etc/locale.conf

sed -i '$a LANG="en_US.UTF-8"' /etc/locale.conf
sed -i '$a LANGUAGE="en_US.UTF-8"' /etc/locale.conf
sed -i '$a  SUPPORTED="zh_HK.UTF-8:zh_HK:zh:zh_CN.UTF-8:zh_CN:zh:zh_TW.UTF-8:zh_TW:zh:en_US.UTF-8:en_US:en:zh_CN.GB18030:zh_CN.GB2312:zh_CN"' /etc/locale.conf
sed -i '$a SYSFONT="latarcyrheb-sun16"' /etc/locale.conf

iptables -X
iptables -t nat -X
iptables -F 
iptables -t nat -F
systemctl disable firewalld.service
systemctl disable iptables


sed -i '$a \\' /etc/profile
sed -i '$a \\' /etc/profile
sed -i '$a ###### env ######' /etc/profile
sed -i '$a PATH=$HOME/bin:$PATH' /etc/profile
sed -i '$a ulimit -u 65535' /etc/profile

source /etc/profile


sed -i '/SELINUX=enforcing/s/enforcing/disabled/g' /etc/sysconfig/selinux


userdel blue -r

groupadd blue -g 101 
useradd -u 101 -g blue blue
mkdir -p /home/blue/apps 
mkdir -p /home/blue/bin 
mkdir -p /home/blue/logs/{nginx,apache}
mkdir -p /home/blue/src 
mkdir -p /home/blue/www
mkdir -p /home/blue/backup
mkdir -p /home/blue/tmp
chown -R blue:blue /home/blue/*

touch /root/pass.list
echo "blue:123456"  > /root/pass.list
chpasswd blue < /root/pass.list
rm -rf /root/pass.list




