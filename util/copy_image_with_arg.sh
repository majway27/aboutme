#!/usr/bin/env bash

if [ -z "$1" ]
  then
    echo "No argument supplied"
    exit 1
fi

IMAGEFILE=$1
cp /media/sf_Downloads/aboutme/media/$IMAGEFILE ~/Projects/aboutme/assets/images/
chmod 644  ~/Projects/aboutme/assets/images/$IMAGEFILE
