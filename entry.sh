#!/bin/bash
# trap SIGTERM and gracefully stops alfresco
trap '/opt/alfresco/alfresco.sh stop;exit 0' SIGTERM
set -e
if [ ! -f /opt/alfresco/alf_data/foo.txt ]; then
    cp -Rp /opt/alfresco/alf_data_back/* /opt/alfresco/alf_data;bash /install.sh;/tunerepo.sh;/modifinitpass.sh;/opt/alfresco/alfresco.sh start;/waitready.sh;/opt/alfresco/alfresco.sh stop;/tunesolr.sh;touch /opt/alfresco/alf_data/foo.txt
fi

# setting values for all the "-e ALF_xxx=..." parameters provided at startup
bash /tuneglobal.sh

# starts alfresco
/opt/alfresco/alfresco.sh start;

# loop so container does not exit
while true;do sleep 5;done
