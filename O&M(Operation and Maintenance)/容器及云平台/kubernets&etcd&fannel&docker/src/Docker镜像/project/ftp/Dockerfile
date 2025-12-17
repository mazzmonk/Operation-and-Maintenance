# setup images to use blue project
FROM ubuntu:v0.13   
MAINTAINER abc <abc@gmail.com>
RUN touch /root/pass.list\
&& echo "root:m+zaB+6V"  > /root/pass.list \
&& chpasswd root < /root/pass.list \
&& rm -rf /root/pass.list 


USER root
COPY start.sh /home/blue/bin/


ENTRYPOINT sh /home/blue/bin/start.sh \
&& /usr/sbin/sshd -D
	   
