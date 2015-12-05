#!/bin/bash
if [ ! -f /foo.txt ]; then
    bash /install.sh;/tunerepo.sh;/modifinitpass.sh;/opt/alfresco-5.0.d/alfresco.sh start;/waitready.sh;/opt/alfresco-5.0.d/alfresco.sh stop;/tunesolr.sh;touch /foo.txt
fi

# setting values for all the "-e ALF_xxx=..." parameters provided at startup
bash /tuneglobal.sh

