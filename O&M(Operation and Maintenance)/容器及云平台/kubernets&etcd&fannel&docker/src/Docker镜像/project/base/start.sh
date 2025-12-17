mount.glusterfs 172.17.10.7:/gv3 /home/blue/share/static
chown -R blue:blue  /home/blue/share/static  
/usr/sbin/cron
/usr/bin/crontab -u blue /home/blue/src/scheduledTasks
/usr/sbin/sshd -D
