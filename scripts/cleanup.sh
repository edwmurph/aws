#!/bin/bash

STACKS='eks
fx-lab
fargate-spot
ecs
dynamodb
fifo
instances
serverless-api
dynamo-items
postgres-serverless
postgres
ses
oidc
vpc'

for STACK in $STACKS; do
  echo "deleting $STACK..."

  sleep 2

  sam delete \
    --stack-name $STACK \
    --profile edwmurph \
    --no-prompts \
    --region us-east-1
done
