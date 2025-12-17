#!/bin/bash
# filename ip projectname pathoffile
# $1:ip 
# $2:projectname
# $3:pathoffile
# if one parameter
#   $1=projectname
#   ip="172.17.56.6"
#   pathoffile="/home/blue/.jenkins/jobs/$1/workspace/build/libs/*.war"
# if two parameter
#   $1=projectname
#   $2=pathoffile
#   ip="172.17.56.6"
# if three parameter
#   $1=ip
#   $2=projectname
#   $3=pathoffile
############################
LOG=/home/blue/logs/putWarToRsync.log
mail=/home/blue/bin/mail.py
#backupdir=/home/blue/backup/project-war/$1
maketime=`date +"%Y%m%d_%H%M%S"`


echo "`date`[INFO] create dir logs" >> $LOG 2>&1
ip="172.17.56.6"
cd /tmp && mkdir logs >> $LOG 2>&1
rsync -R  logs blue@$ip::project --password-file=/home/blue/bin/rsyncd.password >> $LOG 2>&1
cd /tmp && rm -r logs >> $LOG 2>&1

function RsyncFileToServer() {
  echo "Start transmission" >> $LOG 2>&1
  ip=$1;
  projectname=$2;
  pathoffile=$3;

  echo "`date`[INFO] check rsyncd server" >> $LOG 2>&1
  ping -c 4 $ip > /dev/null
  if [ $? -ne 0 ];then
    $mail "The rsync server is down, please check the new ip rsync server and land on the server make dir for ever project" >> $LOG 2>&1 
    exit -1
  fi
  
  echo "`date`[INFO] create project dir" >> $LOG 2>&1
  mkdir $2 >> $LOG 2>&1
  rsync -R $2 blue@$ip::project --password-file=/home/blue/bin/rsyncd.password >> $LOG 2>&1
  rm -r $2 >> $LOG 2>&1

  echo "`date`[INFO] rsync file" >> $LOG 2>&1
  rsync -rltgoDvz $3 blue@$ip::project/$2  --password-file=/home/blue/bin/rsyncd.password >> $LOG 2>&1
  if [ $? -ne 0 ];then
    $mail "$1 New war rsync to rsync server failed!" >> $LOG 2>&1
    exit -1
  else
    $mail "$1 New war has been rsync to rsync server successfull!" >> $LOG 2>&1
fi
}

if [ $# -eq 1 ];then
  projectname=$1   
  ip="172.17.56.6"
  pathoffile="/home/blue/.jenkins/jobs/$projectname/workspace/build/libs/*.war"
  RsyncFileToServer $ip $projectname $pathoffile  >> $LOG 2>&1
elif [ $# -eq 2 ];then
  ip=$1
  projectname=$2
  pathoffile="/home/blue/.jenkins/jobs/$projectname/workspace/build/libs/*.war"
  RsyncFileToServer $ip $projectname $pathoffile >> $LOG 2>&1
elif [ $# -eq 3 ];then
  ip=$1
  projectname=$2
  pathoffile=$3
  RsyncFileToServer $ip $projectname $pathoffile >>$LOG 2>&1
else
    echo "Usage:filename ProjectName/IP ProjectName/IP ProjectName PathOfFile" >> $LOG 2>&1
fi

