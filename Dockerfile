FROM  dockerfile/ubuntu
MAINTAINER Philippe Dubois
RUN   apt-get update
RUN   apt-get install -y --no-install-recommends ubuntu-desktop
RUN   apt-get update
RUN   apt-get install -y wget
RUN   wget http://dl.alfresco.com/release/community/5.0.c-build-00145/alfresco-community-5.0.c-installer-linux-x64.bin
RUN   chmod +x ./alfresco-community-5.0.c-installer-linux-x64.bin
RUN   ./alfresco-community-5.0.c-installer-linux-x64.bin --mode unattended --alfresco_admin_password admin
RUN   rm ./alfresco-community-5.0.c-installer-linux-x64.bin
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
ENTRYPOINT /entry.sh;/opt/alfresco-5.0.c/alfresco.sh start;bash

