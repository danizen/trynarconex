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


# Field mappings could also be provided in the create-index script.

# Field mappings can turn off the dynamic indexing for a type, by
# putting "dynamic": false, before the "properties" of that type.

# Index the URL with "fields" so it is both un-analyzed and analyzed

# Turn the "status" field into an "enrichments" field that has a "null_value".
# It's initial value is the null value, and later we write the various 
# enrichments that are done.

curl -X PUT "http://$ES_HOST:$ES_PORT/$ES_INDEX/_mappings/page?pretty=true" --data @- <<EOF
{
  "properties": {
    "content": {
      "type": "$TEXTTYPE"
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
      "type": "$KEYWORDTYPE",
      "store": true
    },
    "domain": {
      $NOTANALYZED
      "type": "$KEYWORDTYPE"
    },
    "language": {
      $NOTANALYZED
      "type": "$KEYWORDTYPE"
    },
    "md5sum": {
      $NOTANALYZED
      "type": "$KEYWORDTYPE",
      "store": true
    },
    "crawled": {
      "type": "date",
      "format": "yyyy-MM-dd HH:mm:ss||yyyy-MM-dd||epoch_millis",
      "store": true
    },
    "status": {
      $NOTANALYZED
      "type":  "$KEYWORDTYPE"
    }
  }
}
EOF

