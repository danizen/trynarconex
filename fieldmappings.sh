#!/bin/bash

ES_HOST=localhost
ES_PORT=9200
ES_INDEX=medlineplus

while getopts 'h:p:i:' opt; do
  case $opt in
    h) ES_HOST=$OPTARG ;;
    p) ES_PORT=$OPTARG ;;
    i) ES_INDEX=$OPTARG ;;
    \?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
  esac
done

curl -X PUT "http://$ES_HOST:$ES_PORT/$ES_INDEX/_mappings/page?pretty=true" --data @- <<EOF
{
  "properties": {
    "content": {
      "type": "text",
      "store": true
    },
    "description": {
      "type": "text",
      "store": true
    },
    "keywords": {
      "type": "keyword"
    },
    "title": {
      "type": "text",
      "store": true
    },
    "url": {
      "type": "keyword"
    },
    "md5sum": {
      "type": "keyword"
    },
    "crawled": {
      "type": "date",
      "format": "yyyy-MM-dd HH:mm:ss||yyyy-MM-dd||epoch_millis"
    }
  }
}
EOF

