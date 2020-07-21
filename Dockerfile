FROM docker.io/ibmcom/websphere-liberty:20.0.0.5-full-java11-openj9-ubi


RUN chgrp -R 0 ./config &&\
	chmond -R g=u ./config

RUN mkdir -p /config/my-special-folder
COPY Dockerfile ./config/my-special-folder

USER 1001
COPY target/simple-stuff.war /config/dropins/
COPY config/server.xml /config/
COPY config/server.env /config/

