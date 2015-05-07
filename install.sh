/sbin/setuser alfresco ./alfresco-community-5.0.d-installer-linux-x64.bin --mode unattended --alfresco_admin_password admin --disable-components alfrescogoogledocs
rm ./alfresco-community-5.0.d-installer-linux-x64.bin
mv /apply_amps_unatended.sh /home/alfresco/alfresco-5.0.d/bin
mv /alfrescotrashcancleaner2.amp /home/alfresco/alfresco-5.0.d/amps
mv /protectnodes.amp /home/alfresco/alfresco-5.0.d/amps
/home/alfresco/alfresco-5.0.d/bin/apply_amps_unatended.sh
mv /custom-surf-application-context.xml /home/alfresco/alfresco-5.0.d/tomcat/shared/classes/alfresco/web-extension
