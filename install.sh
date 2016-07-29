#!/bin/bash
set -e
# Moved installation in Dockerfile
mv /apply_amps_unatended.sh /opt/alfresco/bin
mv /alfrescotrashcancleaner2.amp /opt/alfresco/amps
mv /protectnodes.amp /opt/alfresco/amps
/opt/alfresco/bin/apply_amps_unatended.sh
mv /custom-surf-application-context.xml /opt/alfresco/tomcat/shared/classes/alfresco/web-extension
