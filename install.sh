#!/bin/bash
set -e
# Moved installation in Dockerfile
# ./alfresco-community-5.0.d-installer-linux-x64.bin --mode unattended --alfresco_admin_password admin
rm ./alfresco-community-5.0.d-installer-linux-x64.bin
mv /apply_amps_unatended.sh /opt/alfresco-5.0.d/bin
mv /alfrescotrashcancleaner2.amp /opt/alfresco-5.0.d/amps
mv /protectnodes.amp /opt/alfresco-5.0.d/amps
/opt/alfresco-5.0.d/bin/apply_amps_unatended.sh
mv /custom-surf-application-context.xml /opt/alfresco-5.0.d/tomcat/shared/classes/alfresco/web-extension
