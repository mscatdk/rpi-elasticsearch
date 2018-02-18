FROM alpine:3.7

ENV APP_USER=elasticsearch
ENV APP_HOME=/usr/share/elasticsearch
ENV APP_VERSION=2.4.6

RUN apk update && \
    apk upgrade && \
    apk add bash openjdk8-jre wget && \
    rm -rf /var/cache/apk/* && \
    mkdir -p ${APP_HOME}/data

RUN addgroup -S ${APP_USER} && adduser -S -D -g '' -s /bin/bash -G ${APP_USER} ${APP_USER}

RUN wget "https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/${APP_VERSION}/elasticsearch-${APP_VERSION}.tar.gz" -O /tmp/elasticsearch.tar.gz && \
    tar -xvzf /tmp/elasticsearch.tar.gz && \
    mv elasticsearch-${APP_VERSION}/* ${APP_HOME} && \
    rm -f /tmp/elasticsearch.tar.gz

COPY conf ${APP_HOME}/config

RUN chmod +x ${APP_HOME}/bin/elasticsearch && \
    chown -R elasticsearch:elasticsearch ${APP_HOME}

ENV ES_HEAP_SIZE=512m

USER ${APP_USER}

WORKDIR ${APP_HOME}

VOLUME ["/usr/share/elasticsearch/data"]
EXPOSE 9200 9300
ENTRYPOINT ["/usr/share/elasticsearch/bin/elasticsearch"]
