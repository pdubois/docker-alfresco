if [ ! -f /foo.txt ]; then
    /tunerepo.sh;/modifinitpass.sh;/opt/alfresco-5.0.c/alfresco.sh start;/waitready.sh;/opt/alfresco-5.0.c/alfresco.sh stop;/tunesolr.sh;touch /foo.txt
fi


