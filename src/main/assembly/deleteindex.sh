#!/bin/bash

ES_HOST=http://localhost:9200
ES_INDEX=mplusadmin
ES_USER=""

while getopts 'h:i:u:' opt; do
  case $opt in
    h) ES_HOST=$OPTARG ;;
    i) ES_INDEX=$OPTARG ;;
    u) ES_USER="-u $OPTARG" ;;
    \?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
  esac
done

curl -X DELETE "$ES_HOST/$ES_INDEX?pretty=true" $ES_USER
