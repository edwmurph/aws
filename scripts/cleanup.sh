#!/bin/bash

for STACK in eks fx-lab fargate-spot ecs dynamodb fifo instances serverless-api dynamo-items postgres-serverless postgres oidc vpc; do
  echo "deleting $STACK..."

  sleep 2

  sam delete \
    --stack-name $STACK \
    --profile edwmurph \
    --region us-east-2 \
    --no-prompts
done
