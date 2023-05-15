#!/bin/bash
#
USAGE='USAGE: ./create-stack.sh <STACK_NAME>'
STACK_NAME=${1?$USAGE}

aws cloudformation create-stack \
  --stack-name $STACK_NAME \
  --template-body file://stacks/$STACK_NAME.yaml \
  --profile root

STACK_STATUS='init'

while [ $STACK_STATUS != 'CREATE_COMPLETE' ] && [ $STACK_STATUS != 'ROLLBACK_COMPLETE' ]; do
  STACK_STATUS=$(aws cloudformation describe-stacks \
    --profile root \
    --stack-name $STACK_NAME \
    | jq -r '.Stacks[0].StackStatus')
  echo "STACK_STATUS: $STACK_STATUS"
  sleep 2
done

aws cloudformation describe-stacks \
  --stack-name $STACK_NAME \
  --no-cli-pager \
  --profile root
