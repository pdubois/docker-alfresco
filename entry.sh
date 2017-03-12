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
#     if [ -z ${CONTAINER_FUNCTION+x} ]; then 
#	echo "Tomcat and Postgres running in same container"; 
#     else    
#        echo "Running only $CONTAINER_FUNCTION";
#        export PGPASSWORD=mysecretpassword;
#        /opt/alfresco/psql/opt/alfresco/psql -h "$DB_CONTAINER_NAME" -p "5432" -U postgres < /create.sql;
#    fi
    bash /tunesolr.sh;
    touch /opt/alfresco/alf_data/foo.txt;
fi

# setting values for all the "-e ALF_xxx=..." parameters provided at startup
bash /tuneglobal.sh

# start postgres and alfresco separately
if [ -z ${CONTAINER_FUNCTION+x} ]; then 
	echo "Tomcat and Postgres running in same container"; 
        /opt/alfresco/alfresco.sh start;
else    
	
        echo "Running only $CONTAINER_FUNCTION";
        /opt/alfresco/alfresco.sh start $CONTAINER_FUNCTION;
fi


# loop so container does not exit
while true;do sleep 5;done
