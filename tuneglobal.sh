# setting values for all the "-e ALF_xxx=..." parameters provided at startup
for thing in `env`
do
 if [[ $thing == ALF* ]]; then
# getting the value of the parameter  
     val=`echo "$thing" | awk -F "=" '{print $1}'`
# getting the name value of the configuration variable passed as parameter
     name=`echo "${!val}" | awk -F "=" '{print $1}'`
     varvalue=`echo "${!val}" | awk -F "=" '{print $2}'`
# test if varvalue already configured in alfresco-global.properties
     if grep -q ^$name /opt/alfresco-5.0.c/tomcat/shared/classes/alfresco-global.properties
     then
        sed -i "/opt/alfresco-5.0.c/tomcat/shared/classes/alfresco-global.properties" -e "s/$name=.*/${!val}/g" 
    else
        echo ${!val} >> "/opt/alfresco-5.0.c/tomcat/shared/classes/alfresco-global.properties"
    fi
 fi
done
