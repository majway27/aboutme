#!/bin/bash

cd ..

PORT=8080
IP=192.168.140.81
#jekyll serve build --incremental --port $PORT --host $IP
jekyll serve build --port $PORT --host $IP
