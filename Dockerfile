FROM ubuntu
MAINTAINER Philippe Dubois 
RUN   apt-get update && apt-get install -y --no-install-recommends ubuntu-desktop wget curl xmlstarlet
RUN   wget http://dl.alfresco.com/release/community/5.0.d-build-00002/alfresco-community-5.0.d-installer-linux-x64.bin

# make root readable by others
RUN   chmod go+r /root

COPY  build-install.sh install.sh passencode.py modifinitpass.sh tunesolr.sh tunerepo.sh disable-delbackup-context.xml waitready.sh entry.sh tuneglobal.sh alfrescotrashcancleaner2.amp protectnodes.amp apply_amps_unatended.sh /
RUN   chmod +x build-install.sh ./alfresco-community-5.0.d-installer-linux-x64.bin /install.sh /passencode.py /modifinitpass.sh /tunesolr.sh /tunerepo.sh /waitready.sh /entry.sh /tuneglobal.sh /apply_amps_unatended.sh

RUN /build-install.sh

EXPOSE 8080

ENTRYPOINT /entry.sh
