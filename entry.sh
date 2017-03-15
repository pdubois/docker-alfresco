#!/bin/bash
# trap SIGTERM and gracefully stops alfresco
trap '/opt/alfresco/alfresco.sh stop;exit 0' SIGTERM
set -e
if [ ! -f /opt/alfresco/alf_data/foo.txt ]; then
    cp -Rp /opt/alfresco/alf_data_back/* /opt/alfresco/alf_data;
    bash /install.sh;
    bash /tunerepo.sh;
    bash /modifinitpass.sh;
#    /opt/alfresco/alfresco.sh start;
#    /waitready.sh;
#    /opt/alfresco/alfresco.sh stop;
     if [ -z ${CONTAINER_FUNCTION+x} ]; then 
	echo "Tomcat and Postgres running in same container"; 
     else 
        echo "Creating DB from alfresco contaner";    
        export PGPASSWORD=mysecretpassword;/opt/alfresco/postgresql/bin/psql -h "$DB_CONTAINER_NAME" -p "5432" -U postgres < /create.sql
    fi
    echo "After fi1";   
    bash /tunesolr.sh;    
    echo "After fi2";  
    touch /opt/alfresco/alf_data/foo.txt;
    echo "After fi3"
fi
    echo "After fi4";
# setting values for all the "-e ALF_xxx=..." parameters provided at startup
bash /tuneglobal.sh
    echo "After fi5";
# start postgres and alfresco separately
if [ -z ${CONTAINER_FUNCTION+x} ]; then 
	echo "Tomcat and Postgres running in same container"; 
        /opt/alfresco/alfresco.sh start;
else    
	
        echo "Running only $CONTAINER_FUNCTION";
        /opt/alfresco/alfresco.sh start $CONTAINER_FUNCTION;
fi
    echo "After fi6";

# loop so container does not exit
while true;do sleep 5;done;
