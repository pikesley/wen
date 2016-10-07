#!/bin/bash

while [ 1 ]
do
  echo `date` >> /tmp/hit-clock

  curl --request PATCH \
       --header "Content-Type:application/json" \
       --header "Accept: application/json" \
       --data '{"mode":"time"}' \
       http://localhost/display

  sleep 10s
done
