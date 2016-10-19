#!/bin/bash

date >> /tmp/date

curl --request POST \
     --silent \
     --header "Content-Type:application/json" \
     --header "Accept: application/json" \
     http://localhost:8080/time
