#!/bin/bash

curl -X PUT "http://localhost:9200/medlineplus?pretty=true" --data @- <<EOF
{
  "settings": {
    "index": {
      "number_of_shards": 1,
      "number_of_replicas": 2
    }
  }
}
EOF
