FROM ubuntu:xenial
MAINTAINER Philippe Dubois 
ENV DEBIAN_FRONTEND noninteractive
RUN   apt-get update && apt-get install -y --no-install-recommends ubuntu-desktop && apt-get update && apt-get install -y wget && wget https://sourceforge.net/projects/alfresco/files/Alfresco%20201707%20Community/alfresco-community-installer-201707-linux-x64.bin && chmod +x ./*.bin 
# make root readable by others    
RUN   chmod go+r /root
COPY  passencode.py /
COPY  modifinitpass.sh /
COPY  tunesolr.sh /
COPY  tunerepo.sh /
COPY  setenv.sh /
COPY  disable-delbackup-context.xml /
RUN   chmod +x /passencode.py && chmod +x /modifinitpass.sh && chmod +x /tunesolr.sh && chmod +x /tunerepo.sh && chmod +x setenv.sh
RUN   apt-get update && apt-get install -y curl
COPY  waitready.sh /
RUN   chmod +x /waitready.sh
COPY  entry.sh /
RUN   chmod +x /entry.sh
COPY  tuneglobal.sh /
RUN   chmod +x /tuneglobal.sh
COPY  protectnodes.amp /
# apply amps
COPY  apply_amps_unatended.sh /
RUN   chmod +x /apply_amps_unatended.sh
# configure for allowing and managing correctly user names containing '@', see http://docs.alfresco.com/4.2/tasks/usernametypes-mix-config.html
COPY  /custom-surf-application-context.xml /
# RUN   mv /custom-surf-application-context.xml /opt/alfresco/tomcat/shared/classes/alfresco/web-extension
COPY install.sh /
# run the installer inside image build
RUN ./alfresco-community-installer-201707-linux-x64.bin --mode unattended --alfresco_admin_password admin --prefix /opt/alfresco
RUN rm ./alfresco-community-installer-201707-linux-x64.bin
RUN mv /opt/alfresco/tomcat/bin/setenv.sh /opt/alfresco/tomcat/bin/setenv.sh.back
RUN mv /setenv.sh /opt/alfresco/tomcat/bin/setenv.sh
RUN mv /opt/alfresco/alf_data /opt/alfresco/alf_data_back
RUN mkdir /opt/alfresco/alf_data
COPY create.sql /
RUN   apt-get update && apt-get install -y vim
# test if alfresco server alive and responsive
HEALTHCHECK --interval=1m --timeout=5s \
  CMD curl -f http://localhost:8080/alfresco || exit 1
EXPOSE 8443
ENTRYPOINT ["/entry.sh"]


