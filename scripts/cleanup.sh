#!/bin/bash

for STACK in fifo rds instances serverless-api vpc; do
  echo "deleting $STACK..."

  sleep 2

  sam delete \
    --stack-name $STACK \
    --profile edwmurph \
    --region us-east-2 \
    --no-prompts
done
