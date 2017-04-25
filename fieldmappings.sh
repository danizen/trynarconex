#!/bin/bash

curl -X PUT "http://localhost:9200/medlineplus/_mappings/page?pretty=true" --data @- <<EOF
{
  "properties": {
    "content": {
      "type": "text"
    },
    "description": {
      "type": "text"
    },
    "document.reference": {
      "type": "keyword"
    },
    "keywords": {
      "type": "text"
    },
    "referrer": {
      "type": "keyword"
    },
    "title": {
      "type": "text"
    },
    "url": {
      "type": "keyword"
    }
  }
}
EOF

