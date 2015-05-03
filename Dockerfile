FROM ubuntu
MAINTAINER Philippe Dubois
RUN   apt-get update
RUN   apt-get install -y --no-install-recommends ubuntu-desktop
RUN   apt-get update
RUN   apt-get install -y wget
RUN   wget http://dl.alfresco.com/release/community/5.0.c-build-00145/alfresco-community-5.0.c-installer-linux-x64.bin
RUN   chmod +x ./alfresco-community-5.0.c-installer-linux-x64.bin
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
RUN   apt-get install -y curl
RUN   apt-get install -y xmlstarlet
COPY  waitready.sh /
RUN   chmod +x /waitready.sh
COPY  entry.sh /
RUN   chmod +x /entry.sh
COPY  tuneglobal.sh /
RUN   chmod +x /tuneglobal.sh
COPY  alfrescotrashcancleaner2.amp  /
COPY  protectnodes.amp /
# apply amps
COPY  apply_amps_unatended.sh /
RUN   chmod +x /apply_amps_unatended.sh
# configure for allowing and managing correctly user names containing '@', see http://docs.alfresco.com/4.2/tasks/usernametypes-mix-config.html
COPY  /custom-surf-application-context.xml /
# RUN   mv /custom-surf-application-context.xml /opt/alfresco-5.0.c/tomcat/shared/classes/alfresco/web-extension
COPY install.sh /
ENTRYPOINT /entry.sh;/opt/alfresco-5.0.c/alfresco.sh start;bash

