docker-alfresco
===============

Generate a docker Ubuntu based image for Alfresco Community version 5.0.c

Description
===========

 The Dockerfile builds from "dockerfile/ubuntu" see https://registry.hub.docker.com/search?q=dockerfile/ubuntu
 
- Installs "ubuntu-desktop" required for Alfresco transformation
- Dockerfile defines an "ENTRYPOINT" performing following configurations when containter is started first:
	- Reduces system.content.orphanProtectDays to 1. Goal, saving space by reducing how long "orphan" content is kept.
	- Disable "deletedContentBackupListener" transfering deleted content files to "contentstore.deleted" no need
	 to empty the folder manually to recuperate physical space.
	- modifinitpass.sh reinitialize the initial repo password or "admin" to value of the INITIAL_PASS env variable
         passed when container initialy started
    - tunesolr.sh disable solr encription between solr and alfresco for small cpu gain. solr and alfresco 
         are installed on same server.
    - starts Alfresco 
- Subsequent container start only starting Alfresco
- Configured https://addons.alfresco.com/addons/trashcan-cleaner to remove documents from the bin after 7 days allowing 
  quicker physical space recuperation.

To generate the image from "Dockerfile"
---------------------------------------

cd _folder-containing-Dockerfile_
sudo docker build -t _image-name_ .

Example:

`
sudo docker build -t alfresco-5.0.c.2 .
`

To start a container using the image
===========

sudo docker run -d -e INITAL_PASS=_initial-pass_ -t -i -p 8443:8443 _image-name_

Example:

`
sudo docker run -d -e INITAL_PASS=admun -t -i -p 8443:8443 alfresco-5.0.c.2
`

Note:

Fortunately you can download the pre build image!

`
docker pull pdubois/docker-alfresco
`
