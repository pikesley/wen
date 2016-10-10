#!/bin/bash

while [ 1 ]
do
  echo `date` >> /tmp/hit-clock

  curl --request PUT \
       --header "Content-Type:application/json" \
       --header "Accept: application/json" \
       http://localhost/time

  sleep 10s
done
