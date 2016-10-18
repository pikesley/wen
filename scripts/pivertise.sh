#!/bin/bash

if [ `sudo /sbin/ifconfig | grep wlan0` ]; then
  INTERFACE=wlan0
else
  INTERFACE=eth0
fi

curl https://pivertiser.herokuapp.com/`hostname`/`sudo /sbin/ifconfig ${INTERFACE} | grep 'inet addr' | tr -s ' ' ' ' | cut -d ' ' -f 3 | cut -d ':' -f 2`
