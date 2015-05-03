./alfresco-community-5.0.c-installer-linux-x64.bin --mode unattended --alfresco_admin_password admin --disable-components alfrescogoogledocs
rm ./alfresco-community-5.0.c-installer-linux-x64.bin
mv /apply_amps_unatended.sh /opt/alfresco-5.0.c/bin
mv /alfrescotrashcancleaner2.amp /opt/alfresco-5.0.c/amps
mv /protectnodes.amp /opt/alfresco-5.0.c/amps
/opt/alfresco-5.0.c/bin/apply_amps_unatended.sh
mv /custom-surf-application-context.xml /opt/alfresco-5.0.c/tomcat/shared/classes/alfresco/web-extension
