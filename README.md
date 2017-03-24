# docker-alfresco


Generate a docker Ubuntu based image for Alfresco Community v5.2.0 with Alfresco Share v5.2.e (see http://eu.dl.alfresco.com.s3.amazonaws.com/release/community/201702-build-00016/alfresco-community-installer-201702-linux-x64.bin) 

## Description


 The Dockerfile builds from "dockerfile/ubuntu" see https://hub.docker.com/_/ubuntu/
 
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
- Configured [alfrescoprotectnode](https://github.com/pdubois/alfrescoprotectnode) to protect some "well known" nodes against acidental deletion.
- Some support for [dockercloud](https://www.docker.com/products/docker-cloud) is included. It allows fast deployment of containers in the cloud on Azure, Digital Ocean, AWS, and SoftLayer.
  

## To generate the image from "Dockerfile"

```
cd _folder-containing-Dockerfile_
sudo docker build -t _image-name_ .
```

Examples:

```
sudo docker build -t alfresco-5.2.0 .
```

A more complete example is located [here](https://github.com/pdubois/docker-alfresco/blob/master/startcontainerexample.sh)


## To start a container using the image


```
sudo docker run -d -e INITIAL_PASS=_initial-pass_ -t -i -p 8443:8443 _image-name_
```

Example:

```
sudo docker run -d -e INITIAL_PASS=admun -t -i -p 8443:8443 alfresco-5.2.0
```

Note:

Fortunately you can download the pre build image from the corresponding [docker hub automatic build](https://registry.hub.docker.com/u/pdubois/docker-alfresco/) using the following command.

```
docker pull pdubois/docker-alfresco
```
## To stop your container

```
sudo docker stop -t <SECONDS>  <CONTAINER ID>
```

The above command will stop your container with a grace period of SECONDS. Grace period gives the opportunity to alfresco process to stop gracefully ( example: flushing buffers).
The “entry.sh” script executed while starting traps   SIGTERM signal and calls execute “/opt/alfresco/alfresco.sh stop” when container is stopped.

Exit code of the container can be checked using following command:

```
sudo docker inspect -f '{{.State.ExitCode}}' <CONTAINER ID>
```

Under normal circumstance exit code should be “0”. Reasonable value for "SECONDS" is 60.

## Deploying using dockercloud procedure

- First register with [dockercloud](https://docs.docker.com/docker-cloud/)
- [bring in your own node](https://docs.docker.com/docker-cloud/infrastructure/byoh/) in dockercloud.
- Install [dockercloud CLI](https://docs.docker.com/docker-cloud/installing-cli/). Tested using the docker deployement of dockercloud CLI image therefore you need docker installed on the host used to deploy (probably your laptop).
- Get from dockercloud your DOCKERCLOUD_USER and your DOCKERCLOUD_PASS.
- Get [docloud-example.sh](https://github.com/pdubois/docker-alfresco/blob/master/docloud-example.sh)
- Replace with your DOCKERCLOUD_USER and your DOCKERCLOUD_PASS.
- Make "docloud-example.sh" executable and execute it!


## Storing index, content and database outside of containers

The approach applied is to use dedicated container for volume sharing between host and container. 

### Step 1:

Decide where to locate your content, index and database files on your host and create directory for it.

Example:

```
mkdir /home/phil/compose/alf_data
```

### Step 2:

Creating the container for content, index and database pointing to the folder created in Step1


Example:

```
docker create -v /home/phil/compose/alf_data:/opt/alfresco/alf_data  --name phil-volumes ubuntu /bin/true
``` 

Notes:

- The above container does not run anything, it has to exist and publishes a volume (-v internal-container-path:host-path).
- With "-v /home/phil/compose/alf_data:/opt/alfresco/alf_data" defines a mapping between container and host file system.
"/home/phil/compose/alf_data" is the path to "alf_data" from inside the container and "/opt/alfresco/alf_data" the path
to same "alf_data" on your host.



### Step 3:

Start your container using volume from container created on "Step 2"

```

docker run -d -e INITIAL_PASS=admun \
-e ALF_1=mail.host=smtp.gmail.com \
put your options here...
--volumes-from phil-volumes \
-t -i -p 8450:8443 pdubois/docker-alfresco
```

Notes:

- The created container will be **throw-away containers/disposable** because all the Alfresco related data state
(index, DB and content) is located under "/opt/alfresco/alf_data" on the container.
- The rest of the state is Alfresco deployment related (configuration files, Tomcat server, DB server ...) is located in the image 
(pdubois/docker-alfresco in this example) or in specific options (-e < ... >). Therefore a container instance can be restarted
using the similar "docker run ..." command eventually with different options if different configuration is required.
- To create a backup, you only need to backup what is located under your "data" directory on the host
( /opt/alfresco/alf_data in the example ).

##Running Alfresco and database in separate containers

Depending on the environment variable **CONTAINER_FUNCTION** value passed when running container your container will run Alfresco and postgres together if **CONTAINER_FUNCTION** is undefined. If  **CONTAINER_FUNCTION** equals ***tomcat***  it will start tomcat with Alfresco deployed but no DB. DB will run in a separate container called **postgres3** in the example here under. Database creation script will be ran from the "tomcat" container when started initially.

###Example:
To run this example a dedicated docker network will be created (see: https://docs.docker.com/engine/userguide/networking/)

```
 
# create a dedicated network to run in isolation
docker network create --driver bridge isolated_nw
# starting db tier on the network 
docker run --network=isolated_nw --name postgres3 -e POSTGRES_PASSWORD=mysecretpassword -d postgres:9.4.4
 # starting Alfresco tier
docker run --network=isolated_nw -d -e INITIAL_PASS=admun  -e CONTAINER_FUNCTION=tomcat -e ALF_1='db.url.EQ.jdbc:postgresql:\/\/postgres3:5432\/${db.name}'   -e ALF_2='db.password.EQ.mysecretpassword'  -e DB_CONTAINER_NAME=postgres3  -e ALF_3='db.username.EQ.postgres' -t -i -p 8443 alfresco
```

Alternatively, you can use [docker-compose](https://docs.docker.com/compose/) to start database container and Alfresco tier in one single command. Here under the **docker-compose.yml** file content:

```
version: '2'
services:
   alfresco:
       image: "pdubois/docker-alfresco:master"
       ports:
        - "8443"
       environment:
        - INITIAL_PASS=admun
        - CONTAINER_FUNCTION=tomcat
        - ALF_1=db.url.EQ.jdbc:postgresql:\/\/postgres:5432\/alfresco
        - ALF_2=db.password.EQ.mysecretpassword  
        - ALF_3=db.username.EQ.postgres
        - DB_CONTAINER_NAME=postgres
       depends_on:
        - postgres
   postgres:
       image: postgres:9.4.4
       environment:
        - POSTGRES_PASSWORD=mysecretpassword
``` 

To start the stack in a single command:

```
docker-compose up
```

A more complete example including [search server 1.0.0 based on SOLR6](https://sourceforge.net/projects/alfresco/files/Alfresco%20201702%20Community/alfresco-search-services-1.0.0.zip) can be found [here](https://hub.docker.com/r/pdubois/solr6/) 



