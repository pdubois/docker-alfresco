#!/bin/bash
#/opt/alfresco/solr4/workspace-SpacesStore/conf/solrcore.properties
#/opt/alfresco/solr4/archive-SpacesStore/conf/solrcore.properties
# alfresco.cron=0/15 * * * * ? *
# slowing down solr tracking
set -e
sed -i /opt/alfresco/solr4/workspace-SpacesStore/conf/solrcore.properties -e "s/alfresco\.cron=.*/alfresco\.cron=0\/30 \* \* \* \* \? \*/g"
sed -i /opt/alfresco/solr4/archive-SpacesStore/conf/solrcore.properties -e "s/alfresco\.cron=.*/alfresco\.cron=0\/30 \* \* \* \* \? \*/g"

# Disabling solr security
# alfresco.secureComms=none
sed -i /opt/alfresco/solr4/workspace-SpacesStore/conf/solrcore.properties -e "s/alfresco\.secureComms=.*/alfresco\.secureComms=none/g"
sed -i /opt/alfresco/solr4/archive-SpacesStore/conf/solrcore.properties -e "s/alfresco\.secureComms=.*/alfresco\.secureComms=none/g"




# Disable solr4 backup
echo "solr.backup.alfresco.cronExpression=0 0 0 1 1 ? 2200" >> "/opt/alfresco/tomcat/shared/classes/alfresco-global.properties"
echo "solr.backup.archive.cronExpression=0 0 0 1 1 ? 2200" >>  "/opt/alfresco/tomcat/shared/classes/alfresco-global.properties"

# Disable solr security alfresco side
echo "solr.secureComms=none" >> "/opt/alfresco/tomcat/shared/classes/alfresco-global.properties"

if [ ! -z "$SOLR_TRACKING" ]; then
# enable.alfresco.tracking=true | false
   sed -i /opt/alfresco/solr4/workspace-SpacesStore/conf/solrcore.properties -e "s/enable.alfresco.tracking=.*/enable.alfresco.tracking=$SOLR_TRACKING/g"
   sed -i /opt/alfresco/solr4/archive-SpacesStore/conf/solrcore.properties -e "s/enable.alfresco.tracking=.*/enable.alfresco.tracking=$SOLR_TRACKING/g"
fi






