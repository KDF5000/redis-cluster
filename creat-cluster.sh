#!/bin/bash
path=`pwd`

if [ "$1" == "start" ]
then
	for ((i=0; i<6; ++i))
	do
		echo "start redis server 700$i..."
		cd ${path}/700$i && ${path}/redis-server redis.conf && cd ${path}
	done
	#creat cluster
	echo "create replicas..."
	${path}/redis-trib.rb create --replicas 1 127.0.0.1:7000 127.0.0.1:7001 \
	127.0.0.1:7002 127.0.0.1:7003 127.0.0.1:7004 127.0.0.1:7005 
fi

if [ "$1" == "stop" ]
then 
    for ((i=0; i<6; ++i))
	do
		echo "stop redis server 700$i..."
		${path}/redis-cli -p 700$i shutdown nosave
	done
fi

if [ "$1" == "clean" ]
then
    cd 
    rm -rf ${path}/700*/*.log
    rm -rf ${path}/700*/appendonly*.aof
    rm -rf ${path}/700*/dump*.rdb
    rm -rf ${path}/700*/nodes*.conf
    exit 0
fi