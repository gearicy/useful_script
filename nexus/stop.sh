#!/bin/bash

docker-compose down


[root@nexus ~]# docker run -d --restart always -p 8081:8081 --name nexus sonatype/nexus3:3.59.0
80bbd285db0bc84a50b785a2aeb688d8bf6879e5fa1381357fa1426a9f38148a
[root@nexus ~]#