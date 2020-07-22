##  Chapter 1 homework for the DO288 bootcamp

Clone this git repo to your local disk and then use that to create a publicly visible git rep on github.com (the public one, not the IBM enterprise git repo).
It is possible to get this working from the IBM enterprise git repo, but that is a separate excercise. After this code is in the github.com repo, run the 
following instructions.

```
oc new-app --name=simple https://github.com/<your github.com id>/day3-simple-stuff.git
oc expose svc simple
oc patch route simple --type=json -p '[{"op": "add", "path": "/spec/tls", "value": {"termination": "edge"}}, {"op": "add", "path": "/spec/port", "value": {"targetPort": "9080-tcp"}}]'
```

And then, `curl -k https://<hostname for route>/simple-stuff/simple/simon`. This should produce the string "/my-special-folder does not exist"

## Task

0. Delete all existing artifiacts from the previous steps by running "oc delete all -l app=simple"

1. In the docker build, create a directory called /my-special-folder. Copy the Dockerfile in this git repo into that folder. Note that you will need to create this
folder as the root user, otherwise, your creation of the directory will fail during the build.
2. Repeat the new-app, expose, and patch commands provided at the top of this file.
3. Repeat steps 1 and 2, but this time, call the app "even-simpler".
4. Provide the output of the "curl" command shown above for the "simple" and "even-simpler" apps.



simple resp:
```
  FROM docker.io/ibmcom/websphere-liberty@sha256:238ef2f145d04850a3411bb1ea07f54844f33a250b5164f277f8dece5aed41c4
  COPY target/simple-stuff.war /config/dropins/
  COPY config/server.xml /config/
  COPY config/server.env /config/
  USER root
  RUN mkdir -p /my-special-folder
  COPY Dockerfile ./my-special-folder
  ENV "OPENSHIFT_BUILD_NAME"="simple-1" "OPENSHIFT_BUILD_NAMESPACE"="andreisaikouski" "OPENSHIFT_BUILD_SOURCE"="https://github.com/andreisaikouski/day3-simple-stuff" "OPENSHIFT_BUILD_COMMIT"="52a046156898108b6826a58d75eb33fdf8db7238"
  LABEL "io.openshift.build.commit.author"="Andrei Saikouski \u003candrei.saikouski@ibm.com\u003e" "io.openshift.build.commit.date"="Tue Jul 21 21:19:21 2020 -0400" "io.openshift.build.commit.id"="52a046156898108b6826a58d75eb33fdf8db7238" "io.openshift.build.commit.message"="last" "io.openshift.build.commit.ref"="master" "io.openshift.build.name"="simple-1" "io.openshift.build.namespace"="andreisaikouski" "io.openshift.build.source-location"="https://github.com/andreisaikouski/day3-simple-stuff"
```


even-simpler resp:
```
  FROM docker.io/ibmcom/websphere-liberty@sha256:238ef2f145d04850a3411bb1ea07f54844f33a250b5164f277f8dece5aed41c4
  COPY target/simple-stuff.war /config/dropins/
  COPY config/server.xml /config/
  COPY config/server.env /config/
  USER root
  RUN mkdir -p /my-special-folder
  COPY Dockerfile ./my-special-folder
  ENV "OPENSHIFT_BUILD_NAME"="even-simpler-1" "OPENSHIFT_BUILD_NAMESPACE"="andreisaikouski" "OPENSHIFT_BUILD_SOURCE"="https://github.com/andreisaikouski/day3-simple-stuff" "OPENSHIFT_BUILD_COMMIT"="52a046156898108b6826a58d75eb33fdf8db7238"
  LABEL "io.openshift.build.commit.author"="Andrei Saikouski \u003candrei.saikouski@ibm.com\u003e" "io.openshift.build.commit.date"="Tue Jul 21 21:19:21 2020 -0400" "io.openshift.build.commit.id"="52a046156898108b6826a58d75eb33fdf8db7238" "io.openshift.build.commit.message"="last" "io.openshift.build.commit.ref"="master" "io.openshift.build.name"="even-simpler-1" "io.openshift.build.namespace"="andreisaikouski" "io.openshift.build.source-location"="https://github.com/andreisaikouski/day3-simple-stuff"
```
