if [ ! -f /home/alfresco/foo.txt ]; then
    bash /tunerepo.sh;/modifinitpass.sh;/home/alfresco/alfresco-5.0.d/alfresco.sh start;/waitready.sh;/home/alfresco/alfresco-5.0.d/alfresco.sh stop;/tunesolr.sh;touch /home/alfresco/foo.txt
fi

# setting values for all the "-e ALF_xxx=..." parameters provided at startup
bash /tuneglobal.sh

