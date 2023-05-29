#!/bin/bash

for STACK in fx-lab fargate dynamodb fifo instances serverless-api dynamo-items postgres-serverless postgres vpc; do
  echo "deleting $STACK..."

  sleep 2

  sam delete \
    --stack-name $STACK \
    --profile edwmurph \
    --region us-east-2 \
    --no-prompts
done
