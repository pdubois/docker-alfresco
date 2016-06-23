#!/bin/bash
set -e
# do not keep orphan content
echo "system.content.orphanProtectDays=1" >>  "/opt/alfresco/tomcat/shared/classes/alfresco-global.properties"

# configure trashcan cleaner
echo "trashcan.cleaner.protected.day=1" >>  "/opt/alfresco/tomcat/shared/classes/alfresco-global.properties"
echo "trashcan.cleaner.cron=0 0 4 * * ?" >> "/opt/alfresco/tomcat/shared/classes/alfresco-global.properties"
echo "trashcan.cleaner.pagelen=5" >> "/opt/alfresco/tomcat/shared/classes/alfresco-global.properties"
# disabling deleted content being copied to ContentStore.deleted
mv /disable-delbackup-context.xml /opt/alfresco/tomcat/shared/classes/alfresco/extension


