#!/bin/bash
# func:检查更新并检查tomcat是否工作正常
# author:Wang Xingwei
# date:16/08/24
####################################################

#tomcat启动程序(这里注意tomcat实际安装的路径)
TomcatBin=/home/blue/apps/tomcat/bin
TomcatCache=/home/blue/apps/tomcat/work
TomcatLog=/home/blue/apps/tomcat/logs
BackupDir=/home/blue/backup
TomcatRoot=/home/blue/apps/tomcat/webapps/ROOT
UplineWarDir=/home/blue/logs/uplie_war
RsyncWarDir=/home/blue/logs/rsync_war
LOCK=/home/blue/logs/tomcat_lock
CrontFile=/home/blue/src/scheduledTasks
PodName=`hostname |awk -vOFS="-" -F- '{print $1,$2}'`
HostName=`hostname`
RsyncServername=rsync.own-project.svc.cluster.my
RsynServerLogFatherDir=$RsyncServername::project/logs
RsynServerLogSonDir=$RsyncServername::project/logs/$HostName
#定义环境变量
export JAVA_HOME=/usr/java/jdk1.7.0_79
export JRE_HOME=/usr/java/jdk1.7.0_79/jre
export CLASSPATH=/usr/java/jdk1.7.0_79/lib:/usr/java/jdk1.7.0_79/jre/lib:
export PATH=/usr/java/jdk1.7.0_79/bin:$PATH

# 定义要监控的页面地址
WebUrl=http://localhost:8080/checkpage.txt
CheckPage=/home/blue/bin/checkpage.txt

source ~/.bashrc
# 日志输出
GetPageInfo=/home/blue/logs/TomcatMonitor.Info
TomcatMonitorLog=/home/blue/logs/TomcatMonitor.log

# startup tomcat process ... 
StartTom()
{
    echo "[info] 开始启动tomcat"
    cd $TomcatBin
    ./startup.sh 
    $StartTomcat
    TomcatNum=`ps aux|grep "tomcat"|grep -Ev "grep|tomcat_check"|awk -F " " '{print $2}'|wc -l`
    if [ $TomcatNum -eq 0 ];then
        echo "[error]Tomcat启动失败"
    else
        echo "[info]Tomcat启动成功"

    fi  

}


# close tomcat process ...
KillTom()
{
    echo "[info]开始杀死Tomcat进程"
    ps aux|grep "tomcat"|grep -Ev "grep|tomcat_check"|awk -F " " '{print $2}'|xargs kill -9
    TomcatNum=`ps aux|grep "tomcat"|grep -Ev "grep|tomcat_check"|awk -F " " '{print $2}'|wc -l`
    if [ $TomcatNum -eq 0 ];then
	echo "[info]Tomcat 进程全部杀死"
    else
	echo "[error]Tomcat 进程没有被杀死"

    fi	
}

# deployment code 
upline()
{
  KillTom
  echo "[info]开始备份$TomcatRoot目录到$BackupDir"
  rm -rf $BackupDir/ROOT
  cp -a  $TomcatRoot $BackupDir # 将ROOT目录备份
  echo "[info]ROOT目录备份完毕" 
  echo "[info]开始清空$TomcatRoot"
  rm -rf $TomcatRoot/*     # 清空ROOT目录的内容
  echo "[info]$TomcatRoot清理完毕"
  echo "[info]开始解压上线war包到$TomcatRoot"
  unzip -oq $UplineWarDir/* -d  $TomcatRoot #将最新的war包解压到ROOT目录
  cp -a $CheckPage $TomcatRoot/ 
  echo "[info]解压完毕，开始上线"
  StartTom                  # 启动tomcat
}

# check 3 times url,if fails,close scheduledTasks
CheckPage()
{
	
    CheckPageNum=3
    while [ $CheckPageNum -ne 0 ]
    do  
	echo "[info]正在进行第$((4-$CheckPageNum))次页面检测............"
	sleep 60
    	TomcatServiceCode=$(curl -I -m 10  $WebUrl  -o /dev/null -s -w %{http_code})
    	if [ $TomcatServiceCode -eq 200 ];then
        	echo "[info]页面返回码为$TomcatServiceCode,tomcat启动成功,测试页面正常......"
		break
    	else
        	echo "[error]tomcat页面出错,请注意......状态码为$TomcatServiceCode,错误日志已输出到$GetPageInfo"
       	        KillTom  # 杀掉原tomcat进程
        	if [ $CheckPageNum -eq 1 ];then
			echo "[info]多次重启，页面仍无法访问，将该程序从计划任务中剔除"
			sed -i '/watchdog/{s/*/#*/}' $CrontFile
			/usr/bin/crontab /home/blue/src/scheduledTasks
		else
			sleep 3
        		rm -rf $TomcatCache/* # 清理tomcat缓存
			echo "[error]页面访问出错,开始重启tomcat" 
        		StartTom
		fi
	        CheckPageNum=$(($CheckPageNum-1))
    	fi
    done
}

# check tomcat process, next step check url
Monitor()
{
  TomcatID=`ps aux| grep tomcat |grep -Ev "chek_tomcat|grep"|awk -F " " '{print $2}'` 
  if [ -n "$TomcatID" ];then  # 这里判断TOMCAT进程是否存在
    echo "[info]当前tomcat进程ID为:$TomcatID,继续检测页面..."
    CheckPage
  else 
    echo "[error]tomcat进程不存在!tomcat开始自动重启..."
    echo "[info]$StartTomcat,请稍候......"
    rm -rf $TomcatCache
    $StartTomcat
    TomcatID=`ps aux| grep tomcat |grep -Ev "chek_tomcat|grep"|awk -F " " '{print $2}'`
    echo "[info]Tomcat进程为$TomcatID,开始检测页面"
    CheckPage
  fi
  echo "------------------------------"
}

# rsync remote war file to local,online
rsync_war()
{
    echo "[info]开始同步war包"
    rsync  -avvzP  --delete  blue@$RsyncServername::project/$PodName/*  $RsyncWarDir #将当前的war包同步到本地
    if [ $? -ne 0 ];then
      echo "[error]同步war包失败"
    else
      if [ -e $RsyncWarDir/1.war ];then
      	rm $RsyncWarDir/1.war
      fi
      WarNum=`ls $RsyncWarDir/*.war|wc -l`
      if [ $WarNum -eq 1 ];then
        RsyncWarDirFile=`ls $RsyncWarDir`
        UplineWarDirFile=`ls $UplineWarDir`
        cmp  $RsyncWarDir/$RsyncWarDirFile  $UplineWarDir/$UplineWarDirFile      #比较同步过来的war包与线上war包是否有区别
        if [ $? -ne 0 ];then #如果有区别就更新war包，并做上线操作
	  rm -rf /home/blue/tmp/cache/*
	  unzip -oq $RsyncWarDir/$RsyncWarDirFile -d /home/blue/tmp/cache
	  if [ $? -ne 0 ];then
		echo "[error]同步过来的文件无法解压，不做上线操作"
	  else
        	  echo "[info]有新的war包同步过来，开始做上线操作"
	          echo "[info]将旧版war包移动到backup目录下"
	          mv $UplineWarDir/$UplineWarDirFile $BackupDir/  #清除旧的war"
		  echo "[info]移动war包完毕"
		  echo "[info]开始更新上线目录的war包"
       	          cp -a  $RsyncWarDir/$RsyncWarDirFile  $UplineWarDir/ #更新为最新的war包
	          echo "[info]上线目录war包更新完毕"
	          echo "[info]现在开始上线操作"
         	  upline #上线
          fi
	else
		echo "[info]同步的war包没有变化，不做上线操作"
        fi
      else
        echo "[error]同步过来的文件不是一个“.war”文件，不做上线操作"
      fi
    fi
}

# check war dirctory 
CheckDir()
{
    if [ -e $1 ];then
     files=`ls $1/|wc -l`
     if [ -z $files ];then
      touch $1/1.war
      echo "[info]$1 为空，创建了1.war！"
     else
      echo "[info]$1 不为空！"
      fi
    else
      mkdir $1
      touch $1/1.war
      echo "[info]不存在$1,创建了$1,同时创建1.war"
    fi
}

#将日志同步到rsync服务器上
Rsynclog()
{
    mkdir $HostName
    rsync -R  $HostName  blue@$RsynServerLogFatherDir --password-file=/home/blue/bin/rsyncd.password
    rsync -rltgoDvz  $TomcatLog/*  blue@$RsynServerLogSonDir  --password-file=/home/blue/bin/rsyncd.password
    rm -r $HostName
}


# main 
echo "########## `date` ##########"
CheckDir $RsyncWarDir
CheckDir $UplineWarDir
rsync_war #>> $TomcatMonitorLog
Monitor #>> $TomcatMonitorLog
Rsynclog
echo "########## `date` ##########"









