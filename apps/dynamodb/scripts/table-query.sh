#!/bin/bash

aws dynamodb query \
  --table-name albumns \
  --profile edwmurph \
  --key-condition-expression 'artist = :artist and albumn = :albumn' \
  --expression-attribute-values '{":artist": {"S": "Beatles"},":albumn":{"S":"Revolver"}}'
