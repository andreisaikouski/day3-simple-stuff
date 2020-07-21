FROM docker.io/ibmcom/websphere-liberty:20.0.0.5-full-java11-openj9-ubi

RUN chgrp -R 0 ./ && \
	chmond -R g=u ./

RUN mkdir my-special-folder
COPY Dockerfile ./my-special-folder
USER 1001

COPY target/simple-stuff.war /config/dropins/
COPY config/server.xml /config/
COPY config/server.env /config/

