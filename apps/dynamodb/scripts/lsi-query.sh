#!/bin/bash

aws dynamodb query \
  --table-name albumns \
  --profile edwmurph \
  --index-name lsi-artist-sales \
  --key-condition-expression 'artist = :artist and sales > :sales' \
  --expression-attribute-values '{":artist": {"S":"Beatles"}, ":sales": {"N": "5"}}'
