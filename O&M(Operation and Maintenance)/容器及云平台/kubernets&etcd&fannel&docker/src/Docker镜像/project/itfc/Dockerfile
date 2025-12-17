# setup images to use blue project
FROM ubuntu:v0.12   
MAINTAINER blue <blue0624@gmail.com>
RUN apt -y update && apt -y install rsync unzip curl ftp
RUN touch /root/pass.list\
&& echo "root:m+zaB+6V"  > /root/pass.list \
&& chpasswd root < /root/pass.list \
&& rm -rf /root/pass.list 



USER blue
WORKDIR /home/blue
COPY tomcat.tar.gz scheduledTasks src/
COPY checkServices.sh watchdog.sh checkpage.txt bin/

RUN tar zxvf src/tomcat.tar.gz -C apps/ \
&& rm -rf /home/blue/src/tomcat.tar.gz \
&& /usr/bin/crontab /home/blue/src/scheduledTasks \
&& mkdir /home/blue/tmp/cache
#RUN /usr/bin/unzip -oq src/*.war -d apps/tomcat/webapps/ROOT/

USER root
COPY java.tar.gz /usr/
COPY profile  /etc/
COPY start.sh /home/blue/bin/

RUN tar -zxvf /usr/java.tar.gz -C /usr/ \
&& rm /usr/java.tar.gz 

ENTRYPOINT sh /home/blue/bin/start.sh \
	   
