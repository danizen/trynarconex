#!/bin/bash

ES_HOST=http://localhost:9200
ES_INDEX=mplusadmin
ES_USER=""

NSHARDS=2
NREPLICAS=2

while getopts 'h:i:u:s:r:' opt; do
  case $opt in
    h) ES_HOST=$OPTARG ;;
    i) ES_INDEX=$OPTARG ;;
    u) ES_USER="-u $OPTARG" ;;
    s) NSHARDS=$OPTARG ;;
    r) NREPLICAS=$OPTARG ;;
    \?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
  esac
done

curl -X PUT "$ES_HOST/$ES_INDEX?pretty=true" $ES_USER --data @- <<EOF
{
  "settings": {
    "index": {
      "number_of_shards": $NSHARDS,
      "number_of_replicas": $NREPLICAS
    }
  }
}
EOF
