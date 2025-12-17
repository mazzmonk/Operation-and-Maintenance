
/usr/bin/dockerd \
--exec-root="/home/blue/apps/docker/var/run/docker" \
-g "/home/blue/apps/docker/var/lib/docker" \
-p "/home/blue/apps/docker/var/run/docker.pid" \
#--storage-driver "devicemapper" \
#--storage-opt "dm.fs=xfs" \
#--storage-opt "dm.basesize=30G" \
-H "unix:///home/blue/apps/docker/var/run/socket" >> /home/blue/apps/docker/logs/docker.log 2>&1 &



yum remove docker docker-client docker-client-latest docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine


yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

yum install docker-ce

yum list docker-ce --showduplicates | sort -r


systemctl start docker
