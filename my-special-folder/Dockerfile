FROM docker.io/ibmcom/websphere-liberty:20.0.0.5-full-java11-openj9-ubi

RUN mkdir -p /my-special-folder
COPY Dockerfile ./my-special-folder

RUN chgrp -R 0 ./my-special-folder &&\
	chmond -R g=u ./my-special-folder

USER 1001

COPY target/simple-stuff.war /config/dropins/
COPY config/server.xml /config/
COPY config/server.env /config/

