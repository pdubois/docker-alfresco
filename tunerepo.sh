echo "system.content.orphanProtectDays=1" >>  "/opt/alfresco-5.0.c/tomcat/shared/classes/alfresco-global.properties"
mv /disable-delbackup-context.xml /opt/alfresco-5.0.c/tomcat/shared/classes/alfresco/extension

# sed -i /opt/alfresco-5.0.c/tomcat/bin/setenv.sh -e "s/Xmx3986M/Xmx2048M/g"
