#!/bin/bash
#$BROKERNAME="localhost"
#$BROKER_URI="tcp://127.0.0.1:61616,tcp://127.0.0.1:61616,tcp://127.0.0.1:61616"
#URI="masterslave:($BROKERS_URI)" 
#$ZOOKEEPER_ADDRESS="127.0.0.1:2181,127.0.0.1:2181,127.0.0.1:2181"
#$HOSTNAME="127.0.0.1"
####################
set -e

ACTIVEMQ_PREFIX="/home/blue/apps/activemq"
ACTIVEMQ_CONFIG="$ACTIVEMQ_PREFIX/conf"
ACTIVEMQ_BIN="$ACTIVEMQ_PREFIX/bin"



if [ "$BROKERNAME" -a "$BROKER_URI" -a "$ZOOKEEPER_ADDRESS" -a "$HOSTNAME" ];then
  sed -ri -e "/brokerName/s/localhost/$BROKERNAME/" \
  -e "/masterslave/s#tcp\:\/\/127\.0\.0\.1\:61616\,tcp\:\/\/127\.0\.0\.1\:61616\,tcp\:\/\/127\.0\.0\.1\:61616#$BROKER_URI#" \
  -e "/zkAddress/s#127\.0\.0\.1\:2181\,127\.0\.0\.1\:2181\,127\.0\.0\.1\:2181#$ZOOKEEPER_ADDRESS#" \
  -e "/hostname/s/127\.0\.0\.1/$HOSTNAME/" $ACTIVEMQ_CONFIG/activemq.xml
fi

gosu blue $ACTIVEMQ_BIN/activemq console



