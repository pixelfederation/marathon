################################################################################
# marathon: 1.4.0
# Date: 02/20/2017
# Marathon Version: 1.4.0-1.0.631.ubuntu1404
# Mesos Version: 1.1.0-2.0.107.ubuntu1404
#
# Description:
# Marathon Mesos framework. Made for executing long running processes
# Former MAINTAINER Bob Killen / killen.bob@gmail.com / @mrbobbytables
################################################################################

FROM pixelfederation/mesos-base:1.4.0

MAINTAINER Milan Baran / mbaran@pixelfederation.com / @mbaran


ENV VERSION_MARATHON=1.4.0-1.0.631.ubuntu1404

RUN apt-get -y update                   \
 && apt-get -y install                  \
    marathon=$VERSION_MARATHON          \
 && mkdir -p /etc/marathon/conf         \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
   
COPY ./skel /

RUN chmod +x init.sh  \
 && chown -R logstash-forwarder:logstash-forwarder /opt/logstash-forwarder                                             \
 && wget -P /usr/share/java http://central.maven.org/maven2/org/codehaus/groovy/groovy-all/2.4.5/groovy-all-2.4.5.jar  \
 && wget -P /usr/share/java http://central.maven.org/maven2/net/logstash/logback/logstash-logback-encoder/4.5.1/logstash-logback-encoder-4.5.1.jar

ENV JSONLOGBACK=$JAVACPROOT/logstash-logback-encoder-4.5.1.jar:$JAVACPROOT/groovy-all-2.4.5.jar

#marathon web and LIBPROCESS_PORT
EXPOSE 8080 9000

CMD ["./init.sh"]
