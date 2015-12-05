#!/bin/bash
set -e
until [ "`curl --silent --show-error --connect-timeout 1 -I http://localhost:8080/share | grep 'Found'`" != "" ];
do
  echo --- sleeping for 10 seconds
  sleep 10
done

echo Tomcat is ready!
