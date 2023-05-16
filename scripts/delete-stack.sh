#!/bin/bash

USAGE='USAGE: npm run delete-stack -- <STACK_NAME>'
STACK_NAME=${1?$USAGE}

aws cloudformation delete-stack --stack-name $STACK_NAME --profile root

STACK_STATUS='DELETE_IN_PROGRESS'

# while [ $STACK_STATUS != 'CREATE_COMPLETE' ] && [ $STACK_STATUS != 'ROLLBACK_COMPLETE' ]; do
while [ -n "$STACK_STATUS" ] && [ $STACK_STATUS == 'DELETE_IN_PROGRESS' ]; do
  STACK_STATUS=$(aws cloudformation describe-stacks \
    --stack-name $STACK_NAME \
    --profile root 2>/dev/null \
    | jq -r '.Stacks[0].StackStatus')
  echo "STACK_STATUS: $STACK_STATUS"
  sleep 3
done

echo 'Stack deleted!'
