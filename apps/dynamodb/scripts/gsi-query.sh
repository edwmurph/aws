#!/bin/bash

aws dynamodb query \
  --table-name albumns \
  --profile edwmurph \
  --index-name gsi-sales-artist \
  --key-condition-expression 'sales = :sales' \
  --expression-attribute-values '{":sales": {"N": "2"}}'
