#!/bin/bash
# This build-install.sh script is run at docker build time, in the container
set -x
export INITIAL_PASS=admin
# so we can connect from outside to the non-ssl server
export ALF_1=alfresco.host=0.0.0.0
echo Installing Alfresco
/install.sh
echo Configuring Alfresco
/modifinitpass.sh
# setting values for all the "-e ALF_xxx=..." parameters provided at startup
/tunerepo.sh
/tuneglobal.sh

echo Starting Alfresco
/opt/alfresco-5.0.d/alfresco.sh start
/waitready.sh
echo Stopping Alfresco
/opt/alfresco-5.0.d/alfresco.sh stop
touch /installed.txt

# remove this build-time install script
rm /build-install.sh

date
echo Alfresco is installed
