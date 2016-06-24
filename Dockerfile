FROM ubuntu
MAINTAINER Philippe Dubois 
ENV DEBIAN_FRONTEND noninteractive
RUN   apt-get update && apt-get install -y --no-install-recommends ubuntu-desktop && apt-get update && apt-get install -y wget && wget http://dl.alfresco.com/release/community/5.0.d-build-00002/alfresco-community-5.0.d-installer-linux-x64.bin && chmod +x ./alfresco-community-5.0.d-installer-linux-x64.bin
# make root readable by others 
RUN   chmod go+r /root
COPY  passencode.py /
COPY  modifinitpass.sh /
COPY  tunesolr.sh /
COPY  tunerepo.sh /
COPY  disable-delbackup-context.xml /
RUN   chmod +x /passencode.py && chmod +x /modifinitpass.sh && chmod +x /tunesolr.sh && chmod +x /tunerepo.sh
RUN   apt-get update && apt-get install -y curl && apt-get install -y xmlstarlet
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
# RUN   mv /custom-surf-application-context.xml /opt/alfresco/tomcat/shared/classes/alfresco/web-extension
COPY install.sh /
# run the installer inside image build
RUN ./alfresco-community-5.0.d-installer-linux-x64.bin --mode unattended --alfresco_admin_password admin --prefix /opt/alfresco
RUN mv /opt/alfresco/alf_data /opt/alfresco/alf_data_back
RUN mkdir /opt/alfresco/alf_data
ENTRYPOINT /entry.sh;/opt/alfresco/alfresco.sh start;while true;do sleep 20;done

