#!/bin/bash
set -e
ENV_PASS=`python3 /passencode.py`
sed -i /opt/alfresco/tomcat/shared/classes/alfresco-global.properties -e "s/alfresco_user_store\.adminpassword=.*/alfresco_user_store\.adminpassword=$ENV_PASS/g"

