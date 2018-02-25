# rpi-elasticsearch

Elasticsearch (<https://www.elastic.co/products/elasticsearch>) build for Raspberry PI and potentially other ARM devices.

## How to use

The docker container can be executed as follows:

```bash
docker run -d \
           -p 9200:9200 \
           -p 9300:9300 \
           -e ES_HEAP_SIZE=512m
           mscatdk/rpi-elasticsearch:latest
```

where

* 9200: REST API
* 9300: Node communication
* ES_HEAP_SIZE: Max heap size

## Build process

```bash
git clone git@github.com:mscatdk/rpi-elasticsearch.git
cd rpi-elasticsearch

docker build . -t mscatdk/rpi-elasticsearch:latest
```

## Test

The docker image has been tested on the following devices:

* Raspberry PI 3 Model B