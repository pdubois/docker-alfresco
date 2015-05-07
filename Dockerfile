FROM phusion/baseimage:0.9.16
MAINTAINER Philippe Dubois & Paul Snively
RUN   groupadd -r alfresco && useradd -r -g alfresco alfresco && mkdir /home/alfresco && chown alfresco:alfresco /home/alfresco
RUN   curl -LO http://dl.alfresco.com/release/community/5.0.c-build-00145/alfresco-community-5.0.c-installer-linux-x64.bin
RUN   chmod +x ./alfresco-community-5.0.c-installer-linux-x64.bin
RUN   /sbin/setuser alfresco ./alfresco-community-5.0.c-installer-linux-x64.bin --mode unattended --alfresco_admin_password admin --disable-components alfrescogoogledocs
RUN   rm ./alfresco-community-5.0.c-installer-linux-x64.bin
# make root readable by others
RUN   chmod go+r /root
COPY  passencode.py /
RUN   chmod +x /passencode.py
COPY  modifinitpass.sh /
RUN   chmod +x /modifinitpass.sh
COPY  tunesolr.sh /
RUN   chmod +x /tunesolr.sh
COPY  tunerepo.sh /
RUN   chmod +x /tunerepo.sh
COPY  disable-delbackup-context.xml /
RUN   apt-get update
RUN   apt-get install -y xmlstarlet
COPY  waitready.sh /
RUN   chmod +x /waitready.sh
COPY  entry.sh /
RUN   chmod +x /entry.sh
COPY  tuneglobal.sh /
RUN   chmod +x /tuneglobal.sh
COPY  alfrescotrashcancleaner2.amp  /
RUN   mv /alfrescotrashcancleaner2.amp /home/alfresco/alfresco-5.0.c/amps
COPY  protectnodes.amp /
RUN   mv /protectnodes.amp /home/alfresco/alfresco-5.0.c/amps
# apply amps
COPY  apply_amps_unatended.sh /
RUN   chmod +x /apply_amps_unatended.sh
RUN   mv /apply_amps_unatended.sh /home/alfresco/alfresco-5.0.c/bin
RUN   /home/alfresco/alfresco-5.0.c/bin/apply_amps_unatended.sh
# configure for allowing and managing correctly user names containing '@', see http://docs.alfresco.com/4.2/tasks/usernametypes-mix-config.html
COPY  /custom-surf-application-context.xml /
RUN   mv /custom-surf-application-context.xml /home/alfresco/alfresco-5.0.c/tomcat/shared/classes/alfresco/web-extension
RUN   mkdir /etc/service/alfresco
ADD   run.sh /etc/service/alfresco/run
# Use baseimage-docker's init system.
ENTRYPOINT /sbin/setuser alfresco /entry.sh;exec /sbin/my_init
