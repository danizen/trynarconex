#!/bin/bash

ES_HOST=localhost
ES_PORT=9200
ES_INDEX=medlineplus
ES_VERSION=2

while getopts 'h:p:i:v:' opt; do
  case $opt in
    h) ES_HOST=$OPTARG ;;
    p) ES_PORT=$OPTARG ;;
    i) ES_INDEX=$OPTARG ;;
    v) ES_VERSION=$OPTARG ;;
    \?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
  esac
done

if [[ $ES_VERSION -ge 5 ]]; then
  TEXTTYPE=text
  KEYWORDTYPE=keyword
  NOTANALYZED=""
else
  TEXTTYPE=string
  KEYWORDTYPE=string
  NOTANALYZED='"index": "not_analyzed",'
fi

curl -X PUT "http://$ES_HOST:$ES_PORT/$ES_INDEX/_mappings/page?pretty=true" --data @- <<EOF
{
  "properties": {
    "content": {
      "type": "$TEXTTYPE",
      "store": true
    },
    "description": {
      "type": "$TEXTTYPE",
      "store": true
    },
    "keywords": {
      $NOTANALYZED
      "type": "$KEYWORDTYPE"
    },
    "title": {
      "type": "$TEXTTYPE",
      "store": true
    },
    "url": {
      $NOTANALYZED
      "type": "$KEYWORDTYPE"
    },
    "md5sum": {
      $NOTANALYZED
      "type": "$KEYWORDTYPE"
    },
    "crawled": {
      "type": "date",
      "format": "yyyy-MM-dd HH:mm:ss||yyyy-MM-dd||epoch_millis"
    }
  }
}
EOF

