#/home/alfresco/alfresco-5.0.d/solr4/workspace-SpacesStore/conf/solrcore.properties
#/home/alfresco/alfresco-5.0.d/solr4/archive-SpacesStore/conf/solrcore.properties
# alfresco.cron=0/15 * * * * ? *
# slowing down solr tracking
sed -i /home/alfresco/alfresco-5.0.d/solr4/workspace-SpacesStore/conf/solrcore.properties -e "s/alfresco\.cron=.*/alfresco\.cron=0\/30 \* \* \* \* \? \*/g"
sed -i /home/alfresco/alfresco-5.0.d/solr4/archive-SpacesStore/conf/solrcore.properties -e "s/alfresco\.cron=.*/alfresco\.cron=0\/30 \* \* \* \* \? \*/g"

# Disabling solr security
# alfresco.secureComms=none
sed -i /home/alfresco/alfresco-5.0.d/solr4/workspace-SpacesStore/conf/solrcore.properties -e "s/alfresco\.secureComms=.*/alfresco\.secureComms=none/g"
sed -i /home/alfresco/alfresco-5.0.d/solr4/archive-SpacesStore/conf/solrcore.properties -e "s/alfresco\.secureComms=.*/alfresco\.secureComms=none/g"

#  delete security-constraint in solr
xmlstarlet ed  -d "/_:web-app/_:security-constraint" /home/alfresco/alfresco-5.0.d/tomcat/webapps/solr4/WEB-INF/web.xml > /home/alfresco/alfresco-5.0.d/tomcat/webapps/solr4/WEB-INF/web2.xml
rm /home/alfresco/alfresco-5.0.d/tomcat/webapps/solr4/WEB-INF/web.xml
mv /home/alfresco/alfresco-5.0.d/tomcat/webapps/solr4/WEB-INF/web2.xml /home/alfresco/alfresco-5.0.d/tomcat/webapps/solr4/WEB-INF/web.xml

#  delete security-constraint in solr
xmlstarlet ed  -d "/_:web-app/_:security-constraint" /home/alfresco/alfresco-5.0.d/tomcat/webapps/alfresco/WEB-INF/web.xml > /home/alfresco/alfresco-5.0.d/tomcat/webapps/alfresco/WEB-INF/web2.xml
rm /home/alfresco/alfresco-5.0.d/tomcat/webapps/alfresco/WEB-INF/web.xml
mv /home/alfresco/alfresco-5.0.d/tomcat/webapps/alfresco/WEB-INF/web2.xml /home/alfresco/alfresco-5.0.d/tomcat/webapps/alfresco/WEB-INF/web.xml



# Disable solr4 backup
#solr.backup.alfresco.cronExpression=0 0 2 * * ?
#solr.backup.archive.cronExpression=0 0 4 * * ?
#solr.backup.alfresco.cronExpression=0 0 0 1 1 ? 2200
#solr.backup.archive.cronExpression=0 0 0 1 1 ? 2200
echo "solr.backup.alfresco.cronExpression=0 0 0 1 1 ? 2200" >> "/home/alfresco/alfresco-5.0.d/tomcat/shared/classes/alfresco-global.properties"
echo "solr.backup.archive.cronExpression=0 0 0 1 1 ? 2200" >>  "/home/alfresco/alfresco-5.0.d/tomcat/shared/classes/alfresco-global.properties"

# Disable solr security alfresco side
echo "alfresco.secureComms=none" >> "/home/alfresco/alfresco-5.0.d/tomcat/shared/classes/alfresco-global.properties"


#./solr4/archive-SpacesStore/conf/solrconfig.xml
#./solr4/workspace-SpacesStore/conf/solrconfig.xml




