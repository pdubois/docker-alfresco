# docker-alfresco


Generate a docker Ubuntu based image for Alfresco Community version 5.0.d

## Description


 The Dockerfile builds from "dockerfile/ubuntu" see https://registry.hub.docker.com/search?q=dockerfile/ubuntu
 
- Installs "ubuntu-desktop" required for Alfresco transformation
- Dockerfile defines an "ENTRYPOINT" performing following configurations when containter is started first:
	- Reduces system.content.orphanProtectDays to 1. Goal, saving space by reducing how long "orphan" content is kept.
	- Disable "deletedContentBackupListener" transfering deleted content files to "contentstore.deleted" no need
	 to empty the folder manually to recuperate physical space.
	- modifinitpass.sh reinitialize the initial repo password or "admin" to value of the INITIAL_PASS env variable
         passed when container initialy started
    - tunesolr.sh disable solr encription between solr and alfresco for small cpu gain. solr and alfresco backend 
         are installed on same server.
    - starts Alfresco
    - Environment variables having name starting with "ALF_xxx" that are passed using the -e options will be copied or value updated in "alfresco-global.properties". 
       Example: -e ALF_22=share.protocol=https will indicate that protocol for share is https and configuration line will be inserted or updated accordingly in "alfresco-global.properties"
- Subsequent container start is only starting Alfresco adding or updating configuration passed using -e ALF_xxx=conf line. A configuration example on how to pass configuration to Alfresco within the container is included. See: startcontainerexample.sh
- Configured [trashcancleaner](https://github.com/pdubois/trashcancleaner) to remove documents from the bin after 7 days allowing 
  quicker physical space recuperation.
- Configured [alfrescoprotectnode](https://github.com/pdubois/alfrescoprotectnode) to protect some "well known" nodes against acidental deletion.
- Some support for [tutum](https://www.tutum.co/) is included. It allows fast deployment of containers in the cloud on Azure, Digital Ocean, AWS, and SoftLayer.
  

## To generate the image from "Dockerfile"

```
cd _folder-containing-Dockerfile_
sudo docker build -t _image-name_ .
```

Examples:

```
sudo docker build -t alfresco-5.0.d.2 .
```

A more complete example is located [here](https://github.com/pdubois/docker-alfresco/blob/master/startcontainerexample.sh)


## To start a container using the image


```
sudo docker run -d -e INITAL_PASS=_initial-pass_ -t -i -p 8443:8443 _image-name_
```

Example:

```
sudo docker run -d -e INITAL_PASS=admun -t -i -p 8443:8443 alfresco-5.0.d.2
```

Note:

Fortunately you can download the pre build image from the corresponding [docker hub automatic build](https://registry.hub.docker.com/u/pdubois/docker-alfresco/) using the following command.

```
docker pull pdubois/docker-alfresco
```
## Deploying using tutum procedure

- First register with [tutum](https://www.tutum.co/)
- [bring in your own node](https://support.tutum.co/support/solutions/articles/5000513678-bring-your-own-node) in tutum.
- Install [tutum CLI](https://github.com/tutumcloud/tutum-cli). Tested using the docker deployement of tutum CLI image therefore you need docker installed on the host used to deploy (probably your laptop).
- Get from tutum your TUTUM_USER and your TUTUM_APIKEY.
- Get [tutum-start-example.sh](https://github.com/pdubois/docker-alfresco/blob/8386fcad28cefb4c6d23c2c0cca27f641cb1d3c6/tutum-start-example.sh)
- Replace with your TUTUM_USER and your TUTUM_APIKEY.
- Make "tutum-start-example.sh" executable and execute it!   
