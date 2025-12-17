#!/bin/bash
# author:Wang Xingwei
# date:2016/8/27
##############################

LOCK=/home/blue/logs/tomcat_lock

LockOn()
{
  if [[ -e $LOCK ]]; then
    echo "on" > $LOCK
  else
    touch $LOCK
    echo "on" > $LOCK
  fi
}

LockOff()
{
  echo "off" > $LOCK
}


LockNumber=`cat $LOCK`

if [ $LockNumber = on ]; then
  echo "正在手动上线或回滚，暂时退出"
  exit -1
fi

echo "########## `date` ##########"
LockOn
sh /home/blue/bin/checkServices.sh >> /home/blue/logs/checkServices.log 2>&1 &
LockOff
echo "########## `date` ##########"

