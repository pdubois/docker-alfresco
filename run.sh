#!/bin/sh
exec 2>&1
exec /sbin/setuser alfresco /home/alfresco/alfresco-5.0.c/alfresco.sh start
